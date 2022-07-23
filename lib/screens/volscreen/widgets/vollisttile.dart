import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patients.dart';
import 'package:sample/provider/volanteer.dart';
import 'package:sample/screens/volscreen/volprofilescreen.dart';

// ignore: must_be_immutable
class VolListTile extends StatelessWidget {
  VolListTile({Key? key, required this.volanteer}) : super(key: key);
  final Volanteer volanteer;

  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final patients = Provider.of<PatientsProv>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: (volanteer.accepted as bool)
              ? ColorsKeys[teamByColor[volanteer.team]]
              : Colors.red[300],
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider.value(value: patients),
                    ChangeNotifierProvider.value(value: account)
                  ],
                  child: VolanteerProfileScreen(volanteer, true),
                ),
              ),
            );
          },
          leading: (account.role == 'مسؤول الملف' &&
                  volanteer.role != 'مسؤول الملف')
              ? IconButton(
                  onPressed: () async {
                    await FirebaseDatabase.instance
                        .ref()
                        .child("activation")
                        .child(volanteer.id as String)
                        .update({"accepted": !(volanteer.accepted as bool)});
                    account.setCurrent(account.current);
                  },
                  icon: (volanteer.accepted as bool)
                      ? Icon(
                          Icons.check_box,
                          color: Colors.green,
                        )
                      : Icon(
                          Icons.check_box_outline_blank,
                          color: Colors.white,
                        ),
                )
              : null,
          title: Text(
            volanteer.name as String,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          trailing: FittedBox(
            child: Text(
              volanteer.phone as String,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
