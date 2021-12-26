import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/provider/state.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/illnesslist.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/state_dropdownbutton.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/patient_screen_doctors_dropdownbutton.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/illness.dart';

// ignore: must_be_immutable
class AddPatientPage extends StatelessWidget {
  AddPatientPage({Key? key}) : super(key: key);

  final fkey = GlobalKey<FormState>();

  final TextEditingController patientNameController = TextEditingController();

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

  final Key patientAdressKey = const Key('patientAdress');

  final Key sourceKey = const Key('sourceKey');

  final Key volNameKey = const Key('volNameKey');

  final Key ilnessKey = const Key('ilnessKey');

  final Key latestKey = const Key('latestKey');

  final Key villageKey = const Key('villageKey');

  String? value;

  String? volValue;

  @override
  Widget build(BuildContext context) {
    final stateManagmentTrue = Provider.of<StateManagment>(context);
    final stateManagmentFalse =
        Provider.of<StateManagment>(context, listen: false);
    final doctorProvider = Provider.of<Docs>(context, listen: false);

    Map<String, Object> newPatient = {};
    void save() async {
      if (fkey.currentState!.validate()) {
        if (value != null)
          newPatient['Doctor'] = value as String;
        else
          newPatient['Doctor'] = "";

        newPatient['date'] = DateTime.now().toIso8601String();
        newPatient['state'] =
            stateManagmentTrue.patientVillageDropDownButtonValue.toString();

        final database = FirebaseDatabase.instance.ref();
        fkey.currentState!.save();
        final ref = database.child('patients').push();
        database.child(ref.path).update(newPatient);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: doctorProvider.refresh(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
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
                        newPatient['name'] = v;
                      },
                      validate: (String v) {
                        if (v.length < 4) return 'ادخل اسم صحيح';
                      },
                      multiline: false,
                    ),
                    AddPatientTextField(
                      label: 'رقم التلفون',
                      controller: patientPhoneController,
                      tKey: patientNumKey,
                      save: (v) {
                        newPatient['phoneNum'] = v;
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
                        newPatient['adress'] = v;
                      },
                      validate: (String v) {
                        if (v.length < 4) return 'ادخل عنوان مناسب';
                      },
                    ),
                    AddPatientTextField(
                      label: 'اسم السورس',
                      controller: sourceController,
                      tKey: sourceKey,
                      multiline: false,
                      save: (v) => newPatient['source'] = v,
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
                              value: value,
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
                      save: (v) => newPatient['latest'] = v,
                      multiline: true,
                    ),
                    ElevatedButton(onPressed: save, child: const Text('save')),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
