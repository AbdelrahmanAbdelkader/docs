import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/provider/volanteer.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list_tile.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/widgets/information_tile.dart';

class VolanteerProfileScreen extends StatelessWidget {
  VolanteerProfileScreen(
    this.volanteer, {
    Key? key,
    // this.patients,
  }) : super(key: key);
  Volanteer volanteer;
  @override
  Widget build(BuildContext context) {
    List<Patient> _currentUserPatients = [];
    final patients = Provider.of<PatientsProv>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: FutureBuilder(
          future: patients.refresh(
              volanteer.team as String, volanteer.role as String, context),
          builder: (context, snapshot) {
            patients.patients.forEach((e) {
              if (e.volId == volanteer.id) {
                _currentUserPatients.add(e);
              }
            });
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InformationTile(
                        information: volanteer.name as String, label: 'الاسم:'),
                    InformationTile(
                        information: volanteer.phone as String,
                        label: 'رقم المحمول:'),
                    InformationTile(
                        information: volanteer.email as String,
                        label: 'الايميل'),
                    SizedBox(
                      height: (_currentUserPatients == [])
                          ? size.height * .3
                          : size.height * .04,
                    ),
                    Text(
                      'الحالات',
                      textAlign: TextAlign.start,
                    ),
                    (_currentUserPatients == [])
                        ? const Text('لم يتم رفع حالات')
                        : ListView.builder(
                            shrinkWrap: true,
                            itemBuilder: (context, index) =>
                                ChangeNotifierProvider<Patient>.value(
                              value: _currentUserPatients[index],
                              child: PatientListTile(),
                            ),
                            itemCount: _currentUserPatients.length,
                          ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
