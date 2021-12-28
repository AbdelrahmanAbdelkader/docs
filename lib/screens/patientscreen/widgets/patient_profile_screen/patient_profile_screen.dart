import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/screens/patientscreen/widgets/patient_profile_screen/widgets/patient_profile_listtile.dart';

class PatientProfileScreen extends StatelessWidget {
  const PatientProfileScreen({Key? key, required this.patient})
      : super(key: key);
  final Patient patient;
  @override
  Widget build(BuildContext context) {
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
            trailing: patient.ill,
          ),
          Text(
            'latest',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
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
                  patient.latest!.length,
                  (index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(children: [
                      Expanded(
                          child: Text(
                        patient.latest!.values.elementAt(index)['text'],
                        style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      )),
                      Text(
                        DateFormat('M/d/y').format(DateTime.parse(
                            patient.latest!.values.elementAt(index)['date'])),
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
