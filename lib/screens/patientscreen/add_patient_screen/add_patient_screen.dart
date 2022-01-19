import 'dart:io';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
import 'package:image_picker/image_picker.dart';

// ignore: must_be_immutable
class AddPatientPage extends StatefulWidget {
  AddPatientPage({Key? key}) : super(key: key);

  @override
  State<AddPatientPage> createState() => _AddPatientPageState();
}

class _AddPatientPageState extends State<AddPatientPage> {
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

  List<File> _images = [];

  Future pickImage(bool galery) async {
    List? images;

    if (galery)
      images = await ImagePicker().pickMultiImage();
    else
      images = [await ImagePicker().pickImage(source: ImageSource.camera)];
    if (images != null)
      images.forEach((element) {
        if (element != null) _images.add(File((element as XFile).path));
      });
    setState(() {});
  }

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
          return Builder(builder: (context) {
            final patientProvider = Provider.of<Patient>(context);
            void save(String id) async {
              if (fkey.currentState!.validate()) {
                // if (patientProvider.stateValidate == true) {
                patientProvider.date = DateTime.now().toIso8601String();
                final database = FirebaseDatabase.instance.ref();
                fkey.currentState!.save();
                List imagesUrl = [];
                _images.forEach((element) async {
                  final fileId = DateTime.now().toString();
                  imagesUrl.add('${id}_$fileId');
                  await FirebaseStorage.instance
                      .ref('patients/${id}_$fileId')
                      .putFile(element);
                });
                final ref = database
                    .child('patients')
                    .child(account.team as String)
                    .child(patientProvider.nationalId as String)
                    .update({
                  'images': imagesUrl,
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

<<<<<<< HEAD
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
=======
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
                    // if (patientProvider.stateValidate == false)
                    //   Text("أختار مركز من فضلك"),
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
>>>>>>> 10b17fdb067c95bfc442075f150150fb720f752b
                            ),
                          )
                        ],
                      ),
                    ),
                    AddPatientTextField(
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
                      label: 'اخر ما وصلناله',
                      controller: latestController,
                      tKey: latestKey,
                      validate: (v) {},
                      save: (v) => patientProvider.setLatest(v),
                      multiline: true,
                    ),
                    (_images.length == 0)
                        ? GestureDetector(
                            onTap: () {
                              FocusScope.of(context).unfocus();
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: Column(
                                          children: [
                                            Card(
                                              child: IconButton(
                                                onPressed: () async {
                                                  await pickImage(true);
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.image),
                                              ),
                                            ),
                                            Card(
                                              child: IconButton(
                                                onPressed: () async {
                                                  await pickImage(false);
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.camera),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
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
                            itemCount: _images.length,
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                            ),
                            itemBuilder: (BuildContext context, int index) =>
                                Container(
                              child: Image.file(
                                _images[index],
                              ),
                            ),
                          ),
                    (_images.length > 0)
                        ? IconButton(
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.green,
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              showDialog(
                                  context: context,
                                  builder: (context) => Dialog(
                                        child: Column(
                                          children: [
                                            Card(
                                              child: IconButton(
                                                onPressed: () async {
                                                  await pickImage(true);
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.image),
                                              ),
                                            ),
                                            Card(
                                              child: IconButton(
                                                onPressed: () async {
                                                  await pickImage(false);
                                                  Navigator.of(context).pop();
                                                },
                                                icon: Icon(Icons.camera),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ));
                            },
                          )
                        : Container(),
                    ElevatedButton(
                        onPressed: () => save(account.id as String),
                        child: const Text('save')),
                  ],
                ),
              ),
            );
          });
        },
      ),
    );
  }
}
