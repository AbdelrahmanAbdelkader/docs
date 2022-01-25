import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/volanteer.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final TextEditingController addClassiController = TextEditingController();
  final TextEditingController addTeamController = TextEditingController();
  final fkey = GlobalKey<FormState>();
  bool teaming = false;
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context, listen: false);
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: ElevatedButton(
                child: Text(
                  'تعديل التيمات',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: (teaming)
                    ? null
                    : () {
                        setState(() {
                          teaming = true;
                        });
                      },
              )),
              Expanded(
                  child: ElevatedButton(
                child: Text(
                  'تعديل الاختصاص',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: (!teaming)
                    ? null
                    : () {
                        setState(() {
                          teaming = false;
                        });
                      },
              )),
            ],
          ),
          if (!teaming)
            Form(
              key: fkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade50.withOpacity(.2),
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: Colors.green.shade400)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: TextFormField(
                      controller: addClassiController,
                      validator: (e) {
                        if (e == null || e == '') {
                          return 'أدخل اسم تخصص من فضلك';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'أدخل تخصص جديد',
                        suffixIcon: IconButton(
                          onPressed: () async {
                            if (fkey.currentState!.validate()) {
                              final ref = FirebaseDatabase.instance
                                  .ref()
                                  .child('classification')
                                  .push();
                              await FirebaseDatabase.instance
                                  .ref(ref.path)
                                  .set(addClassiController.text);
                              addClassiController.clear();
                              account.setCurrent(account.current);
                            }
                          },
                          icon: Icon(
                            Icons.add,
                            color: Colors.green[200],
                          ),
                        ),
                        hintStyle: TextStyle(color: Colors.green[200]),
                        // label: Text(label),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (!teaming)
            StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance
                    .ref()
                    .child('classification')
                    .onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.data !=
                      null) if (snapshot.data!.snapshot.value != null) {
                    final data = (snapshot.data!.snapshot.value as Map);
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) => ListTile(
                          title: Text(data.values.elementAt(i)),
                          trailing: (data.values.elementAt(i) == 'غير محدد')
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: Text(
                                                  'Are you sure for delete ${data.values.elementAt(i)}'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('No!')),
                                                TextButton(
                                                    onPressed: () async {
                                                      final allUsers =
                                                          await FirebaseDatabase
                                                              .instance
                                                              .ref()
                                                              .child('users')
                                                              .get();
                                                      if (allUsers.value !=
                                                          null) {
                                                        final usersData =
                                                            allUsers.value
                                                                as Map;
                                                        print(usersData.values);
                                                        for (Map element
                                                            in usersData.values
                                                                .toList()) {
                                                          if (element[
                                                                  'classification'] ==
                                                              data.values
                                                                  .elementAt(
                                                                      i)) {
                                                            await FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child('users')
                                                                .child(usersData
                                                                    .keys
                                                                    .firstWhere((e) =>
                                                                        usersData[
                                                                            e] ==
                                                                        element))
                                                                .child(
                                                                    'classification')
                                                                .set(
                                                                    'غير محدد');
                                                          }
                                                        }
                                                      }
                                                      final allPatients =
                                                          await FirebaseDatabase
                                                              .instance
                                                              .ref()
                                                              .child('patients')
                                                              .get();
                                                      if (allPatients.value !=
                                                          null) {
                                                        final Map patientsData =
                                                            allPatients.value
                                                                as Map;
                                                        for (Map patient
                                                            in patientsData
                                                                .values) {
                                                          if (patient[
                                                                  'illnessType'] ==
                                                              data.values
                                                                  .elementAt(
                                                                      i)) {
                                                            await FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    'patients')
                                                                .child(patient[
                                                                    'nationaId'])
                                                                .child(
                                                                    'illnessType')
                                                                .set(
                                                                    'غير محدد');
                                                          }
                                                        }
                                                      }
                                                      final allDoctors =
                                                          await FirebaseDatabase
                                                              .instance
                                                              .ref()
                                                              .child('doctors')
                                                              .get();
                                                      if (allDoctors.value !=
                                                          null) {
                                                        final Map doctorsData =
                                                            allDoctors.value
                                                                as Map;
                                                        for (Map doctor
                                                            in doctorsData
                                                                .values) {
                                                          if (doctor[
                                                                  'classification'] ==
                                                              data.values
                                                                  .elementAt(
                                                                      i)) {
                                                            await FirebaseDatabase
                                                                .instance
                                                                .ref()
                                                                .child(
                                                                    'doctors')
                                                                .child(doctorsData
                                                                    .keys
                                                                    .firstWhere((e) =>
                                                                        doctorsData[
                                                                            e] ==
                                                                        doctor))
                                                                .child(
                                                                    'classification')
                                                                .set(
                                                                    'غير محدد');
                                                          }
                                                        }
                                                      }
                                                      await FirebaseDatabase
                                                          .instance
                                                          .ref()
                                                          .child(
                                                              'classification')
                                                          .child(data.keys
                                                              .elementAt(i))
                                                          .set(null);
                                                      Navigator.of(ctx).pop();
                                                      if (account
                                                              .classification ==
                                                          data.values
                                                              .elementAt(i))
                                                        account
                                                            .setClassification(
                                                                'غير محدد');
                                                      account.setCurrent(
                                                          account.current);
                                                    },
                                                    child: Text('yes')),
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  )),
                        ),
                      ),
                    );
                  }
                  return Center(child: Text('لا يوجد تخصصات'));
                }),
          if (teaming)
            Form(
              key: fkey,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.green.shade50.withOpacity(.2),
                      borderRadius: BorderRadius.circular(15),
                      border:
                          Border.all(width: 1, color: Colors.green.shade400)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10),
                    child: TextFormField(
                      controller: addTeamController,
                      validator: (e) {
                        if (e == null || e == '') {
                          return 'أدخل اسم التيم من فضلك';
                        }
                      },
                      decoration: InputDecoration(
                        hintText: 'أدخل تيم جديد',
                        suffixIcon: StreamBuilder<DatabaseEvent>(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child('teams')
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) return Container();
                              if (snapshot.data != null) if (snapshot
                                      .data!.snapshot.value !=
                                  null) if ((snapshot.data!.snapshot.value
                                          as Map)
                                      .length ==
                                  ColorsKeys.length)
                                return Text(
                                  'لا يمكن اضافة تيم أخر',
                                  style: TextStyle(
                                      color: Colors.red, fontSize: 18),
                                );

                              return IconButton(
                                onPressed: () async {
                                  if (fkey.currentState!.validate()) {
                                    await FirebaseDatabase.instance
                                        .ref()
                                        .child('teams')
                                        .child(addTeamController.text)
                                        .set((snapshot.data!.snapshot.value !=
                                                null)
                                            ? ColorsKeys.keys
                                                .where((element) => !(snapshot
                                                        .data!
                                                        .snapshot
                                                        .value as Map)
                                                    .values
                                                    .contains(element))
                                                .toList()[0]
                                            : ColorsKeys.keys.first);
                                    addTeamController.clear();
                                    FocusScope.of(context).unfocus();
                                    account.setCurrent(account.current);
                                  }
                                },
                                icon: Icon(
                                  Icons.add,
                                  color: Colors.green,
                                ),
                              );
                            }),
                        hintStyle: TextStyle(color: Colors.green[200]),
                        // label: Text(label),
                        border: InputBorder.none,
                        errorBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          if (teaming)
            StreamBuilder<DatabaseEvent>(
                stream: FirebaseDatabase.instance.ref().child('teams').onValue,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting)
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  if (snapshot.data !=
                      null) if (snapshot.data!.snapshot.value != null) {
                    final data = (snapshot.data!.snapshot.value as Map);
                    return Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) => ListTile(
                          title: Text(data.keys.elementAt(i)),
                          trailing: (data.keys.elementAt(i) == 'مطلق')
                              ? null
                              : IconButton(
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    showDialog(
                                        context: context,
                                        builder: (ctx) => AlertDialog(
                                              title: Text(
                                                  'Are you sure for delete ${data.keys.elementAt(i)}'),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('No!')),
                                                TextButton(
                                                    onPressed: () async {
                                                      final allUsers =
                                                          await FirebaseDatabase
                                                              .instance
                                                              .ref()
                                                              .child('users')
                                                              .get();
                                                      if (allUsers.value !=
                                                          null) {
                                                        final usersData =
                                                            allUsers.value
                                                                as Map;
                                                        for (Map element
                                                            in (usersData)
                                                                .values) {
                                                          if (element['team'] !=
                                                              data.keys
                                                                  .elementAt(i))
                                                            continue;
                                                          Volanteer volanteer =
                                                              Volanteer()
                                                                ..id = usersData
                                                                    .keys
                                                                    .firstWhere((e) =>
                                                                        usersData[
                                                                            e] ==
                                                                        element);
                                                          await FirebaseDatabase
                                                              .instance
                                                              .ref()
                                                              .child('users')
                                                              .child(volanteer
                                                                  .id as String)
                                                              .child('team')
                                                              .set('مطلق');
                                                          final allpati =
                                                              await FirebaseDatabase
                                                                  .instance
                                                                  .ref()
                                                                  .child(
                                                                      'patients')
                                                                  .get();
                                                          if (allpati.value !=
                                                              null)
                                                            for (Map patient
                                                                in (allpati.value
                                                                        as Map)
                                                                    .values) {
                                                              if (patient[
                                                                      'volanteerId'] ==
                                                                  volanteer
                                                                      .id) {
                                                                await FirebaseDatabase
                                                                    .instance
                                                                    .ref()
                                                                    .child(
                                                                        'patients')
                                                                    .child(patient[
                                                                        'nationaId'])
                                                                    .update({
                                                                  'team': 'مطلق'
                                                                });
                                                              }
                                                            }
                                                        }
                                                      }
                                                      await FirebaseDatabase
                                                          .instance
                                                          .ref()
                                                          .child('teams')
                                                          .child(data.keys
                                                              .elementAt(i))
                                                          .set(null);
                                                      if (account.team ==
                                                          data.keys
                                                              .elementAt(i))
                                                        account.setTeam('مطلق');
                                                      account.setCurrent(
                                                          account.current);
                                                      Navigator.of(ctx).pop();
                                                    },
                                                    child: Text('yes')),
                                              ],
                                            ));
                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: ColorsKeys[data.values.elementAt(i)],
                                  )),
                        ),
                      ),
                    );
                  }
                  return Center(child: Text('لا يوجد تيمات'));
                }),
        ],
      ),
    );
  }
}