import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/patientdropdown.dart';
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

  final Key patientNameKey = const Key('patientName');

  final Key patientNumKey = const Key('patientNum');

  final Key patientAdressKey = const Key('patientAdress');

  final Key sourceKey = const Key('sourceKey');

  final Key volNameKey = const Key('volNameKey');

  final Key ilnessKey = const Key('ilnessKey');

  final Key latestKey = const Key('latestKey');

  String? value;

  String? volValue;

  @override
  Widget build(BuildContext context) {
    Map<String, Object> newPatient = {};
    void save() async {
      if (fkey.currentState!.validate()) {
        if (value != null)
          newPatient['Doctor'] = value as String;
        else
          newPatient['Doctor'] = "";
        if (volValue != null)
          newPatient['volName'] = volValue as String;
        else
          newPatient['volName'] = "";
        newPatient['date'] = DateTime.now().toIso8601String();
        final database = FirebaseDatabase.instance.ref();
        fkey.currentState!.save();
        final ref = await database.child('patients').push();
        database.child(ref.path).update(newPatient);
        // await FirebaseFirestore.instance
        //     .collection('doctors')
        //     .doc()
        //     .update(newPatient);
        // await FirebaseFirestore.instance.collection('patients').add(newPatient);
        Navigator.pop(context);
      }
    }

    return Scaffold(
      appBar: AppBar(),
      body: Form(
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
                  if (v.length != 10 && v.length != 11) return 'ادخل رقم صحيح';
                },
                multiline: false,
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
              Row(
                children: [
                  PatientDropDown(
                    path: 'doctors',
                    text: 'اختر الطبيب المتابع',
                    value: value,
                  ),
                  PatientDropDown(
                    text: 'اختر المتطوع المتابع',
                    path: 'volanteers',
                    value: volValue,
                  )
                ],
              ),
              const Text('التشخيص'),
              Ilness(
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
              Text(Random(15).nextInt(1 << 32).toString())
            ],
          ),
        ),
      ),
    );
  }
}
