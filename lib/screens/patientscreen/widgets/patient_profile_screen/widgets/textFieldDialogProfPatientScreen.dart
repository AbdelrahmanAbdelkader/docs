import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';
class TextFieldDialog extends Dialog {
  TextFieldDialog({
    required String typeChanges,
    required String currentValue,
    required TextEditingController controller,
    required String keyOfDataBase,
  }) : super(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(typeChanges),
              Text(currentValue),
              TextField(
                controller: controller,
              ),
              Builder(builder: (context) {
                return TextButton(
                    onPressed: () async {
                      final account =
                          Provider.of<Account>(context, listen: false);
                      final patient =
                          Provider.of<Patient>(context, listen: false);
                      if (keyOfDataBase != 'nationId')
                        await FirebaseDatabase.instance
                            .ref()
                            .child('patients')
                            .child(account.team as String)
                            .child(patient.nationalId as String)
                            .update({keyOfDataBase: controller.text});
                      else {
                        await FirebaseDatabase.instance
                            .ref()
                            .child('patients')
                            .child(patient.team as String)
                            .child(controller.text)
                            .update({
                          'team': patient.team,
                          'volanteerId': patient.volId,
                          'volanteerName': patient.volName,
                          'patientName': patient.name,
                          'nationaId': controller.text,
                          'docId': patient.docId,
                          'docName': patient.doctor,
                          'illnessType': patient.illnessType,
                          'illness': patient.illness,
                          'costs': Map.fromIterable(
                            patient.costs,
                            key: (e) => e['id'],
                            value: (e) => {
                              'التكليف': e['التكليف'],
                              'القيمة': e['القيمة']
                            },
                          ),
                          'adress': patient.address,
                          'phone': patient.phone,
                          'source': patient.source,
                          'latests': Map.fromIterable(
                            patient.latests,
                            key: (e) {
                              return e['id'];
                            },
                            value: (e) {
                              if (e['date'] == null)
                                e['date'] = DateTime.now().toIso8601String();
                              return {
                                'date': e['date'],
                                'title': e['title'],
                              };
                            },
                          ),
                          'state': patient.state,
                          'date': patient.date,
                        });
                        await FirebaseDatabase.instance
                            .ref()
                            .child('patients')
                            .child(patient.team as String)
                            .child(patient.nationalId as String)
                            .set(null);
                      }
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      account.setCurrent(account.current);
                    },
                    child: Text('save'));
              }),
            ],
          ),
        );
}