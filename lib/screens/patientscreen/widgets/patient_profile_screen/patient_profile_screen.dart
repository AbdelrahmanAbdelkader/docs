import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';

import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/patient_profile_listtile.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';

//need to clean
class PatientProfileScreen extends StatelessWidget {
  PatientProfileScreen({
    Key? key,
  }) : super(key: key);
  TextEditingController dialogController = TextEditingController();
  final Key dialogKey = const Key('dialogKey');
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.green,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: [
          PatientProfieListTile(
            title: 'الاسم :',
            trailing: patient.name,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'اسم المتابع',
            trailing: patient.volName,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'الرقم القومي :',
            trailing: patient.nationalId,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'المركز :',
            trailing: patient.state,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'العنوان :',
            trailing: patient.address,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'رقم المحمول :',
            trailing: patient.phone,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'السورس :',
            trailing: patient.source,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'اسم الطبيب المتابع :',
            trailing: patient.doctor,
            sameUser: sameUser,
          ),
          PatientProfieListTile(
            title: 'نوع المرض :',
            trailing: patient.illnessType,
            sameUser: sameUser,
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
              if (patient.volId == account.id)
                IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => Dialog(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        'أدخل أخر ما وصلته مع الحالة :-',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      Text(
                                        patient.name as String,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green,
                                        ),
                                      ),
                                      AddPatientTextField(
                                        controller: dialogController,
                                        label: 'ادخل الاضافه',
                                        multiline: false,
                                        save: (v) {},
                                        validate: (v) {},
                                        tKey: dialogKey,
                                      ),
                                      TextButton(
                                          onPressed: () async {
                                            await FirebaseDatabase.instance
                                                .ref()
                                                .child('patients')
                                                .child(account.team as String)
                                                .child(patient.nationalId
                                                    as String)
                                                .child('latests')
                                                .child(
                                                    '${(DateTime.now().second)}:${(DateTime.now().millisecond)}')
                                                .set({
                                              'title': dialogController.text,
                                              'date': DateTime.now().toString(),
                                            });
                                            Navigator.of(ctx).pop();
                                            Navigator.of(context).pop();
                                          },
                                          child: Text('save')),
                                    ],
                                  ),
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
