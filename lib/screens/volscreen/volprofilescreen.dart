import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/provider/volanteer.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list_tile.dart';
import 'package:sample/screens/volscreen/settingScreen.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/widgets/information_tile.dart';
import 'package:sizer/sizer.dart';

class VolanteerProfileScreen extends StatelessWidget {
  VolanteerProfileScreen(
    this.volanteer,
    this.canExit, {
    Key? key,
    // this.patients,
  }) : super(key: key);
  Volanteer volanteer;
  bool canExit;
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    print(volanteer.role);
    List<Patient> _currentUserPatients = [];
    List<String> roles = [
      ...role,
      'مسؤول تيم',
      'مسؤول دكاترة',
      'مسؤول الملف',
      'مسؤول المتطوعين'
    ];
    final patients = Provider.of<PatientsProv>(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          if (account.role == 'مسؤول الملف' && volanteer.id == account.id)
            IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider.value(
                        value: account, child: SettingScreen())));
              },
              icon: Icon(Icons.settings),
            ),
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          ),
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder(
          future: patients.refresh(context, account),
          builder: (context, snapshot) {
            patients.patients.forEach((e) {
              if (e.volId == volanteer.id) {
                _currentUserPatients.add(e);
              }
            });
            return StreamBuilder<Object>(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child('users')
                    .child(volanteer.id as String)
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  return SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InformationTile(
                              information: volanteer.name as String,
                              label: 'الاسم:'),
                          InformationTile(
                              information: volanteer.phone as String,
                              label: 'رقم المحمول:'),
                          if (!(account.role == 'مسؤول الملف' ||
                              account.role == 'مسؤول المتطوعين'))
                            InformationTile(
                                information: volanteer.team as String,
                                label: 'التيم:'),
                          if (account.role == 'مسؤول الملف' ||
                              account.role == 'مسؤول المتطوعين')
                            FutureBuilder<DataSnapshot>(
                                future: FirebaseDatabase.instance
                                    .ref()
                                    .child('teams')
                                    .get(),
                                builder: (context, teamSnap) {
                                  if (teamSnap.connectionState ==
                                      ConnectionState.waiting)
                                    return CircularProgressIndicator();
                                  if (teamSnap.data !=
                                      null) if (teamSnap.data!.value != null) {
                                    Map teamData = teamSnap.data!.value as Map;

                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 1,
                                              color: Colors.greenAccent),
                                        ),
                                        elevation: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton(
                                            onTap: () => FocusScope.of(context)
                                                .unfocus(),
                                            elevation: 50,
                                            // focusColor: Colors.white,
                                            underline: Container(),
                                            value: volanteer.team,
                                            isExpanded: true,

                                            onChanged: (v) async {
                                              await FirebaseDatabase.instance
                                                  .ref()
                                                  .child('users')
                                                  .child(volanteer.id as String)
                                                  .child('team')
                                                  .set(v);
                                              final allpati =
                                                  await FirebaseDatabase
                                                      .instance
                                                      .ref()
                                                      .child('patients')
                                                      .get();
                                              for (Patient element
                                                  in patients.patients) {
                                                await FirebaseDatabase.instance
                                                    .ref()
                                                    .child('patients')
                                                    .child(element.nationalId
                                                        as String)
                                                    .child('team')
                                                    .set(v);
                                              }
                                              if (account.id == volanteer.id)
                                                account.setTeam(v as String);
                                              volanteer.team = v as String;

                                              account
                                                  .setCurrent(account.current);
                                            },
                                            hint: Text('اختر التيم'),
                                            items: List.generate(
                                                teamData.length, (index) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  teamData.keys
                                                      .elementAt(index),
                                                  style: TextStyle(
                                                      color: ColorsKeys[teamData
                                                          .values
                                                          .elementAt(index)]),
                                                ),
                                                value: teamData.keys
                                                    .elementAt(index),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Text(
                                      'حدث خطأ في عرض ذلك الرجاء التوجه لديفولبر');
                                }),
                          if (!(volanteer.id == account.id))
                            InformationTile(
                                information: (volanteer.classification == null)
                                    ? 'غير محدد'
                                    : volanteer.classification as String,
                                label: 'التخصص:'),
                          if (account.id == volanteer.id)
                            FutureBuilder<DataSnapshot>(
                                future: FirebaseDatabase.instance
                                    .ref()
                                    .child('classification')
                                    .get(),
                                builder: (context, teamSnap) {
                                  if (teamSnap.connectionState ==
                                      ConnectionState.waiting)
                                    return CircularProgressIndicator();
                                  if (teamSnap.data !=
                                      null) if (teamSnap.data!.value != null) {
                                    Map classificationData =
                                        teamSnap.data!.value as Map;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10.0),
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          side: const BorderSide(
                                              width: 1,
                                              color: Colors.greenAccent),
                                        ),
                                        elevation: 0,
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DropdownButton(
                                            onTap: () => FocusScope.of(context)
                                                .unfocus(),
                                            elevation: 50,
                                            // focusColor: Colors.white,
                                            underline: Container(),
                                            value: (classificationData.values
                                                    .contains(volanteer
                                                        .classification))
                                                ? volanteer.classification
                                                : 'غير محدد',
                                            isExpanded: true,

                                            onChanged: (v) async {
                                              await FirebaseDatabase.instance
                                                  .ref()
                                                  .child('users')
                                                  .child(volanteer.id as String)
                                                  .child('classification')
                                                  .set(v);
                                              if (account.id == volanteer.id)
                                                account.setClassification(
                                                    v as String);
                                              volanteer.classification =
                                                  v as String;
                                              account
                                                  .setCurrent(account.current);
                                            },
                                            hint: Text('اختر التخصص'),
                                            items: List.generate(
                                                classificationData.length,
                                                (index) {
                                              return DropdownMenuItem(
                                                child: Text(
                                                  classificationData.values
                                                      .elementAt(index),
                                                  style: TextStyle(
                                                      color: ColorsKeys[
                                                          classificationData
                                                              .values
                                                              .elementAt(
                                                                  index)]),
                                                ),
                                                value: classificationData.values
                                                    .elementAt(index),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    );
                                  }
                                  return Text(
                                      'حدث خطأ في عرض ذلك الرجاء التوجه لديفولبر');
                                }),
                          if (!(account.role == 'مسؤول الملف'))
                            InformationTile(
                                information: volanteer.role as String,
                                label: 'الدور:'),
                          if (account.role == 'مسؤول الملف')
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: const BorderSide(
                                      width: 1, color: Colors.greenAccent),
                                ),
                                elevation: 0,
                                child: Container(
                                  padding: const EdgeInsets.all(8.0),
                                  child: DropdownButton(
                                    onTap: () =>
                                        FocusScope.of(context).unfocus(),
                                    elevation: 50,
                                    // focusColor: Colors.white,
                                    underline: Container(),
                                    value: volanteer.role,
                                    isExpanded: true,

                                    onChanged: (v) async {
                                      await FirebaseDatabase.instance
                                          .ref()
                                          .child('users')
                                          .child(volanteer.id as String)
                                          .child('role')
                                          .set(v);
                                      if (account.id == volanteer.id) {
                                        account.current = 0;
                                        account.setRole(v as String);
                                      }
                                      volanteer.role = v as String;

                                      account.setCurrent(account.current);
                                    },
                                    hint: Text('اختر الدور'),
                                    items: List.generate(roles.length, (index) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          roles.elementAt(index),
                                          style: TextStyle(
                                              color: ColorsKeys[
                                                  roles.elementAt(index)]),
                                        ),
                                        value: roles.elementAt(index),
                                      );
                                    }).toList(),
                                  ),
                                ),
                              ),
                            ),
                          SizedBox(
                            height: (_currentUserPatients == []) ? 30.h : 4.h,
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
                });
          }),
    );
  }
}
