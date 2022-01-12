import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';

class DropDownDialog extends Dialog {
  DropDownDialog(
      {required String typeChanges,
      required Widget dropDownButton,
      required String changes})
      : super(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    typeChanges,
                    style: TextStyle(
                        color: Colors.green,
                        fontSize: 18,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: dropDownButton,
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Builder(
                    builder: (context) {
                      final account =
                          Provider.of<Account>(context, listen: false);
                      final patient =
                          Provider.of<Patient>(context, listen: false);
                      return TextButton(
                        onPressed: () async {
                          await FirebaseDatabase.instance
                              .ref()
                              .child('patients')
                              .child(account.team as String)
                              .child(patient.nationalId as String)
                              .update(
                                (changes != 'docName')
                                    ? {
                                        changes: (changes == 'state')
                                            ? patient.state
                                            : patient.illnessType,
                                      }
                                    : {
                                        'docName': patient.doctor,
                                        'docId': patient.docId,
                                      },
                              );
                          Navigator.of(context).pop();
                          account.setCurrent(account.current);
                        },
                        child: Text('save'),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
}
