import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/patient_screen_doctors_dropdownbutton.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/state_dropdownbutton.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/dropDownDialogProfPatientScreen.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/patient_profile_listtile.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/textFieldDialogProfPatientScreen.dart';
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
    final patients = Provider.of<PatientsProv>(context);
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
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
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
                    child: Divider(),
                  ),
                  PopupMenuItem(
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                        ),
                        Text(
                          'ازل الحالة بالكامل ؟',
                          style: TextStyle(color: Colors.red),
                        ),
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
                builder: (ctx) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: patient),
                    ChangeNotifierProvider.value(value: account),
                  ],
                  child: TextFieldDialog(
                    typeChanges: 'تغيير الاسم',
                    currentValue: patient.name as String,
                    controller: dialogNameController,
                    keyOfDataBase: 'patientName',
                  ),
                ),
              );
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
                builder: (ctx) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: patient),
                    ChangeNotifierProvider.value(value: account),
                  ],
                  child: TextFieldDialog(
                    typeChanges: 'تغيير الرقم القومي',
                    currentValue: patient.nationalId as String,
                    controller: dialogNationIdController,
                    keyOfDataBase: 'nationId',
                  ),
                ),
              );
            },
          ),
          PatientProfieListTile(
            title: 'المركز :',
            trailing: patient.state,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider.value(
                            value: patient,
                          ),
                          ChangeNotifierProvider.value(value: account),
                        ],
                        child: DropDownDialog(
                          typeChanges: 'تغيير المركز',
                          dropDownButton: StateDropDownButton(
                            label: 'اختر المركز',
                            items: states,
                          ),
                          changes: 'state',
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
                builder: (ctx) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: patient),
                    ChangeNotifierProvider.value(value: account),
                  ],
                  child: TextFieldDialog(
                    typeChanges: 'تغيير العنوان',
                    currentValue: patient.address as String,
                    controller: dialogAdressController,
                    keyOfDataBase: 'adress',
                  ),
                ),
              );
            },
          ),
          PatientProfieListTile(
            title: 'رقم المحمول :',
            trailing: patient.phone,
            editFunction: () {
              showDialog(
                context: context,
                builder: (ctx) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: patient),
                    ChangeNotifierProvider.value(value: account),
                  ],
                  child: TextFieldDialog(
                    typeChanges: 'تغيير المحمول',
                    currentValue: patient.phone as String,
                    controller: dialogPhoneController,
                    keyOfDataBase: 'phone',
                  ),
                ),
              );
            },
          ),
          PatientProfieListTile(
            title: 'السورس :',
            trailing: patient.source,
            editFunction: () {
              showDialog(
                context: context,
                builder: (ctx) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: patient),
                    ChangeNotifierProvider.value(value: account),
                  ],
                  child: TextFieldDialog(
                    typeChanges: 'تغيير المصدر',
                    currentValue: patient.source as String,
                    controller: dialogSourceController,
                    keyOfDataBase: 'source',
                  ),
                ),
              );
            },
          ),
          PatientProfieListTile(
            title: 'اسم الطبيب المتابع :',
            trailing: patient.doctor,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider.value(
                            value: patient,
                          ),
                          ChangeNotifierProvider.value(value: account),
                          ChangeNotifierProvider.value(value: patients),
                        ],
                        child: DropDownDialog(
                          typeChanges: 'تغيير الطبيب',
                          dropDownButton: PatientDropDown(
                            text: 'اختر الطبيب المتابع',
                          ),
                          changes: 'docName',
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
                builder: (ctx) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: patient),
                    ChangeNotifierProvider.value(value: account),
                  ],
                  child: TextFieldDialog(
                    typeChanges: 'تغيير المرض',
                    currentValue: patient.illness as String,
                    controller: dialogIllnessController,
                    keyOfDataBase: 'illness',
                  ),
                ),
              );
            },
          ),
          PatientProfieListTile(
            title: 'نوع المرض :',
            trailing: patient.illnessType,
            editFunction: () {
              showDialog(
                  context: context,
                  builder: (ctx) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider.value(value: patient),
                          ChangeNotifierProvider.value(value: account),
                        ],
                        child: DropDownDialog(
                          typeChanges: 'تغيير نوع المرض',
                          dropDownButton: Builder(builder: (context) {
                            final patient = Provider.of<Patient>(context);
                            return DropdownButton(
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
                              value: patient.illnessType,
                              items: speciality
                                  .map((e) => DropdownMenuItem(
                                      child: Text(e), value: e))
                                  .toList(),
                              onChanged: (v) {
                                patient.setillnessType(v as String);
                              },
                            );
                          }),
                          changes: 'illnessType',
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
