import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/patient_screen_doctors_dropdownbutton.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/state_dropdownbutton.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/patient_profile_listtile.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';

//need to clean
class PatientProfileScreen extends StatelessWidget {
  PatientProfileScreen({
    Key? key,
  }) : super(key: key);
  TextEditingController dialogLatestController = TextEditingController();
  TextEditingController dialogCostController = TextEditingController();
  TextEditingController dialogCostValueController = TextEditingController();
  TextEditingController dialogNameController = TextEditingController();
  TextEditingController dialogNationIdController = TextEditingController();
  TextEditingController dialogAdressController = TextEditingController();
  TextEditingController dialogPhoneController = TextEditingController();
  TextEditingController dialogSourceController = TextEditingController();
  TextEditingController dialogIllnessController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patient>(context);
    final account = Provider.of<Account>(context);
    bool sameUser = patient.volId == account.id;
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        title: Text(
          'فورم الحالة',
          style: TextStyle(
            color: Colors.green,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        leading: PopupMenuButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.green,
            ),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Icon(
                            Icons.add,
                            color: Colors.green,
                          ),
                        ),
                        Text('اضف الحالة لصفحة الزوار ؟'),
                      ],
                    ),
                    onTap: () {},
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.green,
                          ),
                        ),
                        Text('ازل الحالة بالكامل ؟'),
                      ],
                    ),
                    onTap: () {},
                  ),
                ]),
        actions: [
          IconButton(
            icon: Icon(
              Icons.arrow_forward_rounded,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          PatientProfieListTile(
            title: 'الاسم :',
            trailing: patient.name,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('تغيير الإسم'),
                            Text(patient.name as String),
                            TextField(
                              controller: dialogNameController,
                            ),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('patients')
                                      .child(account.team as String)
                                      .child(patient.nationalId as String)
                                      .update({
                                    'patientName': dialogNameController.text
                                  });
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                  account.setCurrent(account.current);
                                },
                                child: Text('save')),
                          ],
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'اسم المتابع',
            trailing: patient.volName,
            editFunction: null,
          ),
          PatientProfieListTile(
            title: 'الرقم القومي :',
            trailing: patient.nationalId,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('تغيير الرقم القومي'),
                            Text(patient.nationalId as String),
                            TextField(
                              controller: dialogNationIdController,
                            ),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('patients')
                                      .child(patient.team as String)
                                      .child(dialogNationIdController.text)
                                      .update({
                                    'team': patient.team,
                                    'volanteerId': patient.volId,
                                    'volanteerName': patient.volName,
                                    'patientName': patient.name,
                                    'nationaId': dialogNationIdController.text,
                                    'docId': patient.docId,
                                    'docName': patient.doctor,
                                    'illnessType': patient.illnessType,
                                    'illness': patient.illness,
                                    'costs': Map.fromIterable(
                                      patient.costs,
                                      key: (e) => e['id'],
                                      value: (e) => {
                                        'التكليف': e['التكليف'],
                                        'القيمة': e['القيمة']
                                      },
                                    ),
                                    'adress': patient.address,
                                    'phone': patient.phone,
                                    'source': patient.source,
                                    'latests': Map.fromIterable(
                                      patient.latests,
                                      key: (e) {
                                        return e['id'];
                                      },
                                      value: (e) {
                                        if (e['date'] == null)
                                          e['date'] =
                                              DateTime.now().toIso8601String();
                                        return {
                                          'date': e['date'],
                                          'title': e['title'],
                                        };
                                      },
                                    ),
                                    'state': patient.state,
                                    'date': patient.date,
                                  });
                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('patients')
                                      .child(patient.team as String)
                                      .child(patient.nationalId as String)
                                      .set(null);
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                  account.setCurrent(account.current);
                                },
                                child: Text('save')),
                          ],
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'المركز :',
            trailing: patient.state,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => ChangeNotifierProvider.value(
                        value: patient,
                        child: Dialog(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('تغيير المركز'),
                              StateDropDownButton(
                                label: 'اختر المركز',
                                items: states,
                              ),
                              TextButton(
                                  onPressed: () async {
                                    await FirebaseDatabase.instance
                                        .ref()
                                        .child('patients')
                                        .child(account.team as String)
                                        .child(patient.nationalId as String)
                                        .update({'state': patient.state});
                                    Navigator.of(ctx).pop();
                                    Navigator.of(context).pop();
                                    account.setCurrent(account.current);
                                  },
                                  child: Text('save')),
                            ],
                          ),
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'العنوان :',
            trailing: patient.address,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('تغيير العنوان'),
                            Text(patient.address as String),
                            TextField(
                              controller: dialogAdressController,
                            ),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('patients')
                                      .child(account.team as String)
                                      .child(patient.nationalId as String)
                                      .update({
                                    'adress': dialogAdressController.text
                                  });
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                  account.setCurrent(account.current);
                                },
                                child: Text('save')),
                          ],
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'رقم المحمول :',
            trailing: patient.phone,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('تغيير المحمول'),
                            Text(patient.phone as String),
                            TextField(
                              controller: dialogPhoneController,
                            ),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('patients')
                                      .child(account.team as String)
                                      .child(patient.nationalId as String)
                                      .update({
                                    'phone': dialogPhoneController.text
                                  });
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                  account.setCurrent(account.current);
                                },
                                child: Text('save')),
                          ],
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'السورس :',
            trailing: patient.source,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('تغيير المصدر'),
                            Text(patient.source as String),
                            TextField(
                              controller: dialogSourceController,
                            ),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('patients')
                                      .child(account.team as String)
                                      .child(patient.nationalId as String)
                                      .update({
                                    'source': dialogSourceController.text
                                  });

                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                  account.setCurrent(account.current);
                                },
                                child: Text('save')),
                          ],
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'اسم الطبيب المتابع :',
            trailing: patient.doctor,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => ChangeNotifierProvider.value(
                        value: patient,
                        child: Dialog(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('تغيير الطبيب'),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
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
                              TextButton(
                                  onPressed: () async {
                                    await FirebaseDatabase.instance
                                        .ref()
                                        .child('patients')
                                        .child(account.team as String)
                                        .child(patient.nationalId as String)
                                        .update({
                                      'docId': patient.docId,
                                      'docName': patient.doctor,
                                    });
                                    Navigator.of(ctx).pop();
                                    Navigator.of(context).pop();
                                    account.setCurrent(account.current);
                                  },
                                  child: Text('save')),
                            ],
                          ),
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'المرض :',
            trailing: patient.illness,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => Dialog(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('تغيير المرض'),
                            Text(patient.illness as String),
                            TextField(
                              controller: dialogIllnessController,
                            ),
                            TextButton(
                                onPressed: () async {
                                  await FirebaseDatabase.instance
                                      .ref()
                                      .child('patients')
                                      .child(account.team as String)
                                      .child(patient.nationalId as String)
                                      .update({
                                    'illness': dialogIllnessController.text
                                  });
                                  Navigator.of(ctx).pop();
                                  Navigator.of(context).pop();
                                  account.setCurrent(account.current);
                                },
                                child: Text('save')),
                          ],
                        ),
                      ));
            },
          ),
          PatientProfieListTile(
            title: 'نوع المرض :',
            trailing: patient.illnessType,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => ChangeNotifierProvider.value(
                        value: patient,
                        child: Dialog(
                          child: Builder(builder: (context) {
                            final supPatient = Provider.of<Patient>(context);
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('تغيير نوع المرض'),
                                DropdownButton(
                                  underline: Container(),
                                  isExpanded: true,
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  hint: Text(
                                    'تخصص المرض',
                                  ),
                                  value: supPatient.illnessType,
                                  items: speciality
                                      .map(
                                        (e) => DropdownMenuItem(
                                          child: Text(e),
                                          value: e,
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (v) {
                                    patient.setillnessType(v as String);
                                  },
                                ),
                                TextButton(
                                    onPressed: () async {
                                      await FirebaseDatabase.instance
                                          .ref()
                                          .child('patients')
                                          .child(account.team as String)
                                          .child(
                                              supPatient.nationalId as String)
                                          .update({
                                        'illnessType': supPatient.illnessType
                                      });
                                      Navigator.of(ctx).pop();
                                      Navigator.of(context).pop();
                                      account.setCurrent(account.current);
                                    },
                                    child: Text('save')),
                              ],
                            );
                          }),
                        ),
                      ));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'التكاليف',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              if (patient.volId == account.id ||
                  account.role == 'متطوع غني' ||
                  account.role == 'مسؤول أبحاث')
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => Dialog(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('أدخل تكليف للحالة :-'),
                                    Text(patient.name as String),
                                    TextField(
                                      controller: dialogCostController,
                                    ),
                                    TextField(
                                      controller: dialogCostValueController,
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          await FirebaseDatabase.instance
                                              .ref()
                                              .child('patients')
                                              .child(account.team as String)
                                              .child(
                                                  patient.nationalId as String)
                                              .child('costs')
                                              .child(
                                                  '${(DateTime.now().second)}:${(DateTime.now().millisecond)}')
                                              .set({
                                            'التكليف':
                                                dialogCostController.text,
                                            'القيمة':
                                                dialogCostValueController.text,
                                          });
                                          Navigator.of(ctx).pop();
                                          // dialogCostController.clear();
                                          Navigator.of(context).pop();
                                          account.setCurrent(account.current);
                                        },
                                        child: Text('save')),
                                  ],
                                ),
                              ));
                    },
                    icon: Icon(Icons.add)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  width: 1,
                  color: Colors.blue.shade300,
                ),
              ),
              child: Column(
                children: List.generate(
                  patient.costs.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                        patient.costs[index]['التكليف'],
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                      Text(
                        patient.costs[index]['القيمة'],
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'latest',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              if (patient.volId == account.id ||
                  account.role == 'متطوع غني' ||
                  account.role == 'مسؤول أبحاث')
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => Dialog(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('أدخل أخر ما وصلته مع الحالة :-'),
                                    Text(patient.name as String),
                                    TextField(
                                      controller: dialogLatestController,
                                    ),
                                    TextButton(
                                        onPressed: () async {
                                          await FirebaseDatabase.instance
                                              .ref()
                                              .child('patients')
                                              .child(account.team as String)
                                              .child(
                                                  patient.nationalId as String)
                                              .child('latests')
                                              .child(
                                                  '${(DateTime.now().second)}:${(DateTime.now().millisecond)}')
                                              .set({
                                            'title':
                                                dialogLatestController.text,
                                            'date': DateTime.now().toString(),
                                          });
                                          Navigator.of(ctx).pop();
                                          Navigator.of(context).pop();
                                          account.setCurrent(account.current);
                                        },
                                        child: Text('save')),
                                  ],
                                ),
                              ));
                    },
                    icon: Icon(Icons.add))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                  width: 1,
                  color: Colors.blue.shade300,
                ),
              ),
              child: Column(
                children: List.generate(
                  patient.latests.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                        patient.latests[index]['title'],
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                      Text(
                        DateFormat('M/d/y').format(
                            DateTime.parse(patient.latests[index]['date'])),
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    ]),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
