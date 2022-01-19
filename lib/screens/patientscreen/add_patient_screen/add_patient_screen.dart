import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/illnesslist.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/state_dropdownbutton.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/patient_screen_doctors_dropdownbutton.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class AddPatientPage extends StatelessWidget {
  AddPatientPage({Key? key}) : super(key: key);
  final fkey = GlobalKey<FormState>();

  final TextEditingController patientNameController = TextEditingController();

  final TextEditingController nationalIdController = TextEditingController();

  final TextEditingController patientPhoneController = TextEditingController();

  final TextEditingController patientAdressController = TextEditingController();

  final TextEditingController sourceController = TextEditingController();

  final TextEditingController illnessController = TextEditingController();

  final TextEditingController costController = TextEditingController();

  final TextEditingController costValueController = TextEditingController();

  final TextEditingController latestController = TextEditingController();

  final Key patientNameKey = const Key('patientName');

  final Key patientNumKey = const Key('patientNum');

  final Key nationalIdKey = const Key('NationalIdKey');

  final Key patientAdressKey = const Key('patientAdress');

  final Key sourceKey = const Key('sourceKey');

  final Key illnessKey = const Key('illnessKey');

  final Key latestKey = const Key('latestKey');

  List<String> images = [
    'assets/1.png',
    'assets/2.png',
    'assets/3.png',
    'assets/4.png',
  ];

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final patientsProvider = Provider.of<PatientsProv>(context, listen: false);
    final doctorsProvider = Provider.of<Docs>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: doctorsProvider.refresh(
            account.setCurrent, context, patientsProvider.setCurrentDoctors),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: CircularProgressIndicator(),
            );
          return ChangeNotifierProvider(
            create: (context) => Patient()
              ..volId = account.id
              ..volName = account.name,
            child: Builder(builder: (context) {
              final patientProvider = Provider.of<Patient>(context);
              void save() async {
                if (fkey.currentState!.validate()) {
                  // if (patientProvider.stateValidate == true) {
                  patientProvider.date = DateTime.now().toIso8601String();
                  final database = FirebaseDatabase.instance.ref();
                  fkey.currentState!.save();
                  final ref = database
                      .child('patients')
                      .child(account.team as String)
                      .child(patientProvider.nationalId as String)
                      .update({
                    'team': account.team,
                    'volanteerId': account.id,
                    'volanteerName': patientProvider.volName,
                    'patientName': patientProvider.name,
                    'nationaId': patientProvider.nationalId,
                    'docId': patientProvider.docId,
                    'docName': patientProvider.doctor,
                    'illnessType': patientProvider.illnessType,
                    'illness': patientProvider.illness,
                    'availableForGuests': false,
                    'costs': Map.fromIterable(
                      patientProvider.costs,
                      key: (e) => e['id'],
                      value: (e) =>
                          {'التكليف': e['التكليف'], 'القيمة': e['القيمة']},
                    ),
                    'adress': patientProvider.address,
                    'phone': patientProvider.phone,
                    'source': patientProvider.source,
                    'latests': Map.fromIterable(
                      patientProvider.latests,
                      key: (e) {
                        return e['id'];
                      },
                      value: (e) {
                        if (e['date'] == null)
                          e['date'] = DateTime.now().toIso8601String();
                        return {
                          'date': e['date'],
                          'title': e['title'],
                        };
                      },
                    ),
                    'state': patientProvider.state,
                    'date': patientProvider.date,
                  });
                  Navigator.pop(context);
                  patientsProvider.clear();
                  account.setCurrent((account.current));
                }
                // } else
                //   patientProvider.stateNotvalidated();
              }

              return Form(
                key: fkey,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      AddPatientTextField(
                        label: 'الاسم',
                        controller: patientNameController,
                        tKey: patientNameKey,
                        textInputAction: TextInputAction.next,
                        save: (v) {
                          patientProvider.name = v;
                        },
                        validate: (String v) {
                          if (v.length < 4) return 'ادخل اسم صحيح';
                        },
                        multiline: false,
                      ),
                      AddPatientTextField(
                        label: 'الرقم القومي',
                        controller: nationalIdController,
                        textInputAction: TextInputAction.next,
                        tKey: nationalIdKey,
                        save: (v) {
                          patientProvider.nationalId = v;
                        },
                        validate: (String v) {
                          if (v.length != 14) return 'ادخل رقم قومي صحيح';
                        },
                        multiline: false,
                      ),
                      AddPatientTextField(
                        label: 'رقم التلفون',
                        controller: patientPhoneController,
                        textInputAction: TextInputAction.next,
                        tKey: patientNumKey,
                        save: (v) {
                          patientProvider.phone = v;
                        },
                        validate: (String v) {
                          if (v.length != 10 && v.length != 11)
                            return 'ادخل رقم صحيح';
                        },
                        multiline: false,
                      ),
                      StateDropDownButton(
                        label: 'اختر المركز',
                        items: states,
                      ),
                      AddPatientTextField(
                        textInputAction: TextInputAction.next,
                        label: 'العنوان',
                        controller: patientAdressController,
                        tKey: patientAdressKey,
                        multiline: false,
                        save: (v) {
                          patientProvider.address = v;
                        },
                        validate: (String v) {
                          if (v.length < 4) return 'ادخل عنوان مناسب';
                        },
                      ),
                      // if (patientProvider.stateValidate == false)
                      //   Text("أختار مركز من فضلك"),
                      AddPatientTextField(
                        textInputAction: TextInputAction.next,
                        label: 'اسم السورس',
                        controller: sourceController,
                        tKey: sourceKey,
                        multiline: false,
                        save: (v) => patientProvider.source = v,
                        validate: (v) {
                          if (v.length < 4) return 'ادخل اسم صحيح';
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: PatientDropDown(
                                text: 'اختر الطبيب المتابع',
                              ),
                            )
                          ],
                        ),
                      ),
                      AddPatientTextField(
                        textInputAction: TextInputAction.next,
                        label: 'المرض المصاحب للمريض',
                        controller: illnessController,
                        tKey: illnessKey,
                        multiline: false,
                        save: (v) => patientProvider.illness = v,
                        validate: (String v) {
                          if (v.length == 0) return 'ادخل المرض من فضلك';
                        },
                      ),
                      IllnessList(
                          costController: costController,
                          costValueController: costValueController),
                      AddPatientTextField(
                        textInputAction: TextInputAction.next,
                        label: 'اخر ما وصلناله',
                        controller: latestController,
                        tKey: latestKey,
                        validate: (v) {},
                        save: (v) => patientProvider.setLatest(v),
                        multiline: true,
                      ),
                      (images.length == 0)
                          ? GestureDetector(
                              onTap: () {
                                //دخل الصور و حطها في [images]
                              },
                              child: Container(
                                color: Colors.grey[200],
                                margin: EdgeInsets.only(top: 20),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 40.w, vertical: 10.h),
                                child: Icon(
                                  Icons.add_a_photo,
                                  color: Colors.green,
                                  size: 36,
                                ),
                              ),
                            )
                          : GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: images.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                              ),
                              itemBuilder: (BuildContext context, int index) =>
                                  Container(
                                child: Image.asset(
                                  images[index],
                                ),
                              ),
                            ),
                      (images.length > 0)
                          ? IconButton(
                              icon: Icon(
                                Icons.add_a_photo,
                                color: Colors.green,
                              ),
                              onPressed: () {
                                //نفس اللي فوق زود بيها الصور
                              },
                            )
                          : Container(),
                      ElevatedButton(
                          onPressed: save, child: const Text('save')),
                    ],
                  ),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}
