import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';
import 'package:sample/screens/widgets/custom_text_field.dart';

class TextFieldDialog extends Dialog {
  TextFieldDialog({
    required String typeChanges,
    required String currentValue,
    required TextEditingController controller,
    required String keyOfDataBase,
  }) : super(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: Builder(
            builder: (context) {
              final size = MediaQuery.of(context).size;
              return Container(
                height: size.height * .4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            typeChanges,
                            style: TextStyle(color: Colors.green, fontSize: 20),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * .02,
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side: BorderSide(
                                color: Colors.greenAccent, width: 1)),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:8.0,vertical: 13),
                          child: Row(
                            children: [
                              const Text(
                                'الحالي:',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(currentValue),
                            ],
                          ),
                        ),
                      ),
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                          side: BorderSide(width: 1, color: Colors.greenAccent),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'الجديد',
                              border: InputBorder.none,
                              errorBorder: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              disabledBorder: InputBorder.none,
                              focusedErrorBorder: InputBorder.none,
                            ),
                            controller: controller,
                          ),
                        ),
                      ),
                      TextButton(
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
                                  .update(
                                {
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
                                        e['date'] =
                                            DateTime.now().toIso8601String();
                                      return {
                                        'date': e['date'],
                                        'title': e['title'],
                                      };
                                    },
                                  ),
                                  'state': patient.state,
                                  'date': patient.date,
                                },
                              );
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
                          child: Text('save')),
                    ],
                  ),
                ),
              );
            },
          ),
        );
}
