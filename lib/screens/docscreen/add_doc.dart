import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AddDoctor extends StatelessWidget {
  AddDoctor(this.prove, {Key? ky}) : super(key: ky);
  bool once = true;
  final Doc prove;
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
      print(prove.Id);
      bool validate = keys.currentState!.validate();
      if (validate) {
        // prove.type = prove.val as String;
        keys.currentState!.save();
        DatabaseReference ref;
        print(prove.Id);
        if (prove.Id == null) {
          ref = database.ref().child('doctors').push();
        } else
          ref = database.ref().child('doctors').child(prove.Id as String);
        try {
          database.ref(ref.path).set({
            "phone": prove.phone,
            "agreed": prove.agreed,
            "email": prove.email,
            "hint": prove.hint,
            "name": prove.name,
            "petients": prove.patients.asMap(),
          });
          Navigator.of(context).pop();
        } catch (error) {
          ScaffoldMessenger.of(context).clearSnackBars();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                error.toString(),
              ),
            ),
          );
        }
        // database.ref()
        // .set(toAdd);
        //prove.ref();
      }
    }

    //final staticProve = Provider.of<Doc>(context, listen: false);
    if (once) {
      fitchLastData(prove);
      once = false;
    }
    // staticProve.getTextFields(docNameController, docPhoneController,
    //     docEmailController, hintController);
    return ChangeNotifierProvider.value(
      value: prove,
      child: Builder(builder: (context) {
        final doc = Provider.of<Doc>(context);
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
                      save: (v) => {doc.name = v as String},
                      validate: (v) {
                        if (v!.length < 4) return 'ادخل اسم صحيح';
                      },
                      textInputAction: TextInputAction.next,
                      multiline: false),
                  Row(
                    children: [
                      SizedBox(
                          width: 80.w,
                          child: AddPatientTextField(
                              textInputAction: TextInputAction.next,
                              textInputType: TextInputType.phone,
                              label: 'رقم التليفون',
                              controller: docPhoneController,
                              tKey: docPhoneKey,
                              save: (v) => doc.phone = v as String,
                              validate: (v) {
                                if (v!.length != 10 && v.length != 11) {
                                  return ' ادخل رقم هاتف صحيح';
                                }
                              },
                              multiline: false)),
                      Switch(
                        value: doc.value,
                        onChanged: (v) {
                          doc.setCommuicate(v);
                        },
                      ),
                    ],
                  ),
                  (doc.value)
                      ? Container()
                      : AddPatientTextField(
                          label: 'طريقة التواصل',
                          controller: docEmailController,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.emailAddress,
                          tKey: docEmailKey,
                          save: (v) => doc.email = v as String,
                          validate: (v) {
                            if (!v!.contains('@') || !v.contains('.com')) {
                              return 'ادخل بريد الكتروني صحيح';
                            }
                          },
                          multiline: false),
                  AddPatientTextField(
                      label: 'ملاحظة',
                      controller: hintController,
                      tKey: hintKey,
                      save: (v) => doc.hint = v as String,
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
                          (!doc.agreed)
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
                        doc.toggle();
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      save(doc);
                    },
                    child: const Text('save'),
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(
                        Size.fromWidth(80.w),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
