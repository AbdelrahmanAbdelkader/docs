import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/patient_profile_listtile.dart';

//need to clean
class PatientProfileScreen extends StatelessWidget {
  PatientProfileScreen({
    Key? key,
  }) : super(key: key);
  TextEditingController dialogController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final patient = Provider.of<Patient>(context);
    final account = Provider.of<Account>(context);
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
          ),
          PatientProfieListTile(
              title: 'اسم المتابع', trailing: patient.volName),
          PatientProfieListTile(
            title: 'الرقم القومي :',
            trailing: patient.nationalId,
          ),
          PatientProfieListTile(
            title: 'المركز :',
            trailing: patient.state,
          ),
          PatientProfieListTile(
            title: 'العنوان :',
            trailing: patient.address,
          ),
          PatientProfieListTile(
            title: 'رقم المحمول :',
            trailing: patient.phone,
          ),
          PatientProfieListTile(
            title: 'السورس :',
            trailing: patient.source,
          ),
          PatientProfieListTile(
            title: 'اسم الطبيب المتابع :',
            trailing: patient.doctor,
          ),
          PatientProfieListTile(
            title: 'نوع المرض :',
            trailing: patient.illnessType,
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
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text('أدخل أخر ما وصلته مع الحالة :-'),
                                    Text(patient.name as String),
                                    TextField(
                                      controller: dialogController,
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
                                            'title': dialogController.text,
                                            'date': DateTime.now().toString(),
                                          });
                                          Navigator.of(ctx).pop();
                                          Navigator.of(context).pop();
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
