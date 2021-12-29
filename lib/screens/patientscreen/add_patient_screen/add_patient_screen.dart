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

// ignore: must_be_immutable
class AddPatientPage extends StatelessWidget {
  AddPatientPage(this.refrech, {Key? key}) : super(key: key);
  final Function refrech;
  final fkey = GlobalKey<FormState>();

  final TextEditingController patientNameController = TextEditingController();

  final TextEditingController nationalIdController = TextEditingController();

  final TextEditingController patientPhoneController = TextEditingController();

  final TextEditingController patientAdressController = TextEditingController();

  final TextEditingController sourceController = TextEditingController();

  final TextEditingController volNameController = TextEditingController();

  final TextEditingController illnessController = TextEditingController();

  final TextEditingController latestController = TextEditingController();

  final TextEditingController illnessValueController = TextEditingController();

  final TextEditingController village = TextEditingController();

  final Key patientNameKey = const Key('patientName');

  final Key patientNumKey = const Key('patientNum');

  final Key nationalIdKey = const Key('NationalIdKey');

  final Key patientAdressKey = const Key('patientAdress');

  final Key sourceKey = const Key('sourceKey');

  final Key volNameKey = const Key('volNameKey');

  final Key ilnessKey = const Key('ilnessKey');

  final Key latestKey = const Key('latestKey');

  final Key villageKey = const Key('villageKey');

  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final patientsProvider = Provider.of<PatientsProv>(context, listen: false);
    final doctorsProvider = Provider.of<Docs>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: doctorsProvider.refresh(
            refrech, patientsProvider.setCurrentDoctors),
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
                  if (patientProvider.stateValidate == true) {
                    patientProvider.date = DateTime.now().toIso8601String();
                    final database = FirebaseDatabase.instance.ref();
                    fkey.currentState!.save();
                    // print(account.id);
                    // print(patientProvider.volName);
                    // print(patientProvider.name);
                    // print(patientProvider.docId);
                    // print(patientProvider.doctor);
                    // print(patientProvider.illnessType);
                    // print(Map.fromIterable(
                    //   patientProvider.illnesses,
                    //   key: (e) => e['id'],
                    //   value: (e) =>
                    //       {'المرض': e['المرض'], 'القيمة': e['القيمة']},
                    // ));
                    // print(patientProvider.address);
                    // print(patientProvider.phone);
                    // print(patientProvider.source);
                    // print(Map.fromIterable(
                    //   patientProvider.latests,
                    //   key: (e) {
                    //     return e['id'];
                    //   },
                    //   value: (e) {
                    //     print(e['date']);
                    //     if (e['date'] == null)
                    //       e['date'] = DateTime.now().toIso8601String();
                    //     return {
                    //       'date': e['date'],
                    //       'title': e['title'],
                    //     };
                    //   },
                    // ));
                    // print(patientProvider.state);
                    // print(patientProvider.date);
                    final ref = database
                        .child('patients')
                        .child(account.team as String)
                        .child(patientProvider.nationalId as String)
                        .update({
                      'volanteerId': account.id,
                      'volanteerName': patientProvider.volName,
                      'patientName': patientProvider.name,
                      'nationaId': patientProvider.nationalId,
                      'docId': patientProvider.docId,
                      'docName': patientProvider.doctor,
                      'illnessType': patientProvider.illnessType,
                      'illnesses': Map.fromIterable(
                        patientProvider.illnesses,
                        key: (e) => e['id'],
                        value: (e) =>
                            {'المرض': e['المرض'], 'القيمة': e['القيمة']},
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
                    refrech();
                  }
                } else
                  patientProvider.stateNotvalidated();
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
                      if (patientProvider.stateValidate == false)
                        Text("أختار مركز من فضلك"),
                      AddPatientTextField(
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
                      IllnessList(
                          illnessController: illnessController,
                          illnessValueController: illnessValueController),
                      AddPatientTextField(
                        label: 'اخر ما وصلناله',
                        controller: latestController,
                        tKey: latestKey,
                        validate: (v) {},
                        save: (v) => patientProvider.setLatest(v),
                        multiline: true,
                      ),
                      ElevatedButton(
                          onPressed: save, child: const Text('save')),
                    ],
                    // return Form(
                    // key: fkey,
                    // child: SingleChildScrollView(
                    //   child: Column(
                    //     children: [
                    //       AddPatientTextField(
                    //         label: 'الاسم',
                    //         controller: patientNameController,
                    //         textInputAction: TextInputAction.next,
                    //         tKey: patientNameKey,
                    //         save: (v) {
                    //           newPatient['name'] = v;
                    //   },
                    //   validate: (String v) {
                    //     if (v.length < 4) return 'ادخل اسم صحيح';
                    //   },
                    //   multiline: false,
                    // ),
                    // AddPatientTextField(
                    //   label: 'الرقم القومي',
                    //   controller: nationalIdController,
                    //   textInputAction: TextInputAction.next,
                    //   tKey: nationalIdKey,
                    //   save: (v) {
                    //     newPatient['nationalId'] = v;
                    //   },
                    //   validate: (String v) {
                    //     if (v.length != 14)
                    //       return 'ادخل رقم قومي صحيح';
                    //   },
                    //   multiline: false,
                    // ),
                    // AddPatientTextField(
                    //   label: 'رقم التلفون',
                    //   controller: patientPhoneController,
                    //   textInputAction: TextInputAction.next,
                    //   tKey: patientNumKey,
                    //   save: (v) {
                    //     newPatient['phoneNum'] = v;
                    //   },
                    //   validate: (String v) {
                    //     if (v.length != 10 && v.length != 11)
                    //       return 'ادخل رقم صحيح';
                    //   },
                    //   multiline: false,
                    // ),
                    // StateDropDownButton(
                    //   label: 'اختر المركز',
                    //   items: states,
                    // ),
                    // AddPatientTextField(
                    //   label: 'العنوان',
                    //   controller: patientAdressController,
                    //   textInputAction: TextInputAction.next,
                    //   tKey: patientAdressKey,
                    //   multiline: false,
                    //   save: (v) {
                    //     newPatient['adress'] = v;
                    //   },
                    //   validate: (String v) {
                    //     if (v.length < 4) return 'ادخل عنوان مناسب';
                    //   },
                    // ),
                    // AddPatientTextField(
                    //   label: 'اسم السورس',
                    //   controller: sourceController,
                    //   textInputAction: TextInputAction.next,
                    //   tKey: sourceKey,
                    //   multiline: false,
                    //   save: (v) => newPatient['source'] = v,
                    //   validate: (v) {
                    //     if (v.length < 4) return 'ادخل اسم صحيح';
                    //   },
                    // ),
                    // Padding(
                    //   padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    //   child: Row(
                    //     children: [
                    //       Expanded(
                    //         flex: 1,
                    //         child: PatientDropDown(
                    //           text: 'اختر الطبيب المتابع',
                    //         ),
                    //       )
                    //     ],
                    //   ),
                    // ),
                    // IllnessList(
                    //     illnessController: illnessController,
                    //     illnessValueController: illnessValueController),
                    // AddPatientTextField(
                    //   label: 'اخر ما وصلناله',
                    //   controller: latestController,
                    //   textInputAction: TextInputAction.newline,
                    //   tKey: latestKey,
                    //   validate: (v) {},
                    //   save: (v) => newPatient['latest'] = {
                    //     DateFormat('Hms').format(DateTime.now()): {
                    //       'text': v,
                    //       'date': DateTime.now().toString(),
                    //     }
                    //   },
                    //   multiline: true,
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
