import 'package:flutter/material.dart';
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
          )
        ],
      ),
    );
  }
}
