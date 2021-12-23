import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helper.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/add_patient_text_field.dart';

// ignore: must_be_immutable
class AddDoctor extends StatelessWidget {
  AddDoctor({Key? ky}) : super(key: ky);
  bool once = true;
  final GlobalKey<FormState> keys = GlobalKey<FormState>();
  final TextEditingController docNameController = TextEditingController();
  final TextEditingController docPhoneController = TextEditingController();
  final TextEditingController docEmailController = TextEditingController();
  final TextEditingController hintController = TextEditingController();
  final Key docNameKey = const Key('docName');
  final Key docPhoneKey = const Key('docPhone');
  final Key docEmailKey = const Key('docEmail');
  final Key hintKey = const Key('doctorHint');
  void fitchLastData(Doc doc) {
    doc.getTextFields(docNameController, docPhoneController, docEmailController,
        hintController);
  }

  // @override
  // void didChangeDependencies() {
  //   if (once) {
  //     if (widget.id != null) {
  //       doc.initData(widget.id as String);
  //       //   final database = FirebaseFirestore.instance;
  //       //   database.collection('doctors').doc(widget.id).get().then((value) {
  //       //     agreed = value['agreed'];
  //       //     docNameController.text = value['name'];
  //       //     if (value['phone'] != null) {
  //       //       docPhoneController.text = value['phone'];
  //       //     } else {
  //       //       docEmailController.text = value['email'];
  //       //     }
  //       //     hintController.text = value['hint'];
  //       //     val = value['type'];
  //       //   });
  //     }
  //   }
  //   super.didChangeDependencies();
  // }
  final database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    void save(Doc prove) {
      prove.triedToValidate = true;
      bool validate = keys.currentState!.validate();
      if (prove.val != null && validate) {
        print("sss");
        prove.type = prove.val as String;
        keys.currentState!.save();
        DatabaseReference ref;
        if (prove.Id == null) {
          ref = database.ref().child('doctors').push();
        } else
          ref = database.ref().child('doctors').child(prove.Id as String);
        database.ref(ref.path).set({
          "phone": prove.phone,
          "agreed": prove.agreed,
          "email": prove.email,
          "hint": prove.hint,
          "name": prove.name,
          "petients": prove.patients.asMap(),
          "type": prove.type,
        });
        // database.ref()
        // .set(toAdd);
        Navigator.of(context).pop();
        prove.ref();
      }
    }

    Size size = MediaQuery.of(context).size;
    final prove = Provider.of<Doc>(context);
    final staticProve = Provider.of<Doc>(context, listen: false);
    if (once) {
      fitchLastData(staticProve);
      once = false;
    }
    // staticProve.getTextFields(docNameController, docPhoneController,
    //     docEmailController, hintController);
    print(prove.name);
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: keys,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AddPatientTextField(
                  label: 'اسم الدكتور',
                  controller: docNameController,
                  tKey: docNameKey,
                  save: (v) => {prove.name = v as String},
                  validate: (v) {
                    if (v!.length < 4) return 'ادخل اسم صحيح';
                  },
                  multiline: false),
              Row(
                children: [
                  SizedBox(
                      width: size.width * .8,
                      child: AddPatientTextField(
                          label: 'رقم التليفون',
                          controller: docPhoneController,
                          tKey: docPhoneKey,
                          save: (v) => prove.phone = v as String,
                          validate: (v) {
                            if (v!.length != 10 && v.length != 11) {
                              return ' ادخل رقم هاتف صحيح';
                            }
                          },
                          multiline: false)),
                  Switch(
                    value: prove.value,
                    onChanged: (v) => prove.value = v,
                  ),
                ],
              ),
              (prove.value)
                  ? Container()
                  : AddPatientTextField(
                      label: 'طريقة التواصل',
                      controller: docEmailController,
                      tKey: docEmailKey,
                      save: (v) => prove.email = v as String,
                      validate: (v) {
                        if (!v!.contains('@') || !v.contains('.com')) {
                          return 'ادخل بريد الكتروني صحيح';
                        }
                      },
                      multiline: false),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 50, vertical: 8),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                          side: const BorderSide(
                              width: 1, color: Colors.greenAccent),
                        ),
                        elevation: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          child: DropdownButton(
                            isDense: true,
                            elevation: 0,
                            // focusColor: Colors.white,
                            underline: Container(),
                            value: prove.val,
                            isExpanded: true,
                            hint: const Text('اختر التخصص'),
                            onChanged: (va) => prove.val = va as String,
                            items: List.generate(
                              speciality.length,
                              (index) => DropdownMenuItem(
                                child: Text(
                                  speciality[index],
                                ),
                                value: speciality[index],
                              ),
                            ).toList(),
                          ),
                        ),
                      ),
                    ),
                    if (prove.triedToValidate && prove.val == null)
                      const Text(
                        'اختر التخصص',
                        style: TextStyle(color: Colors.red, fontSize: 12),
                      ),
                  ],
                ),
              ),
              AddPatientTextField(
                  label: 'ملاحظة',
                  controller: hintController,
                  tKey: hintKey,
                  save: (v) => prove.hint = v as String,
                  validate: (v) {},
                  multiline: true),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 7),
                child: GestureDetector(
                  child: Row(
                    children: [
                      const Text('موافق يشتغل معانا؟'),
                      const Spacer(),
                      (!prove.agreed)
                          ? const Icon(
                              Icons.check_box_outlined,
                              color: Colors.red,
                            )
                          : const Icon(
                              Icons.check_box,
                              color: Colors.green,
                            ),
                    ],
                  ),
                  onTap: () {
                    prove.toggle();
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  save(prove);
                },
                child: const Text('save'),
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    Size.fromWidth(size.width * .8),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
