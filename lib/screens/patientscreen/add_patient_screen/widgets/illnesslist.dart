import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/patient.dart';

import 'illnesstextfield.dart';

class IllnessList extends StatelessWidget {
  IllnessList(
      {Key? key,
      required this.illnessController,
      required this.illnessValueController})
      : super(key: key);
  final TextEditingController illnessController;
  final TextEditingController illnessValueController;
  @override
  Widget build(BuildContext context) {
    final patientProvider = Provider.of<Patient>(context);
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: 1,
              color: Colors.greenAccent,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6),
            child: DropdownButton(
              underline: Container(),
              isExpanded: true,
              style: TextStyle(
                color: Colors.green,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              hint: Text(
                'تخصص المرض',
              ),
              value: patientProvider.illnessType,
              items: speciality
                  .map(
                    (e) => DropdownMenuItem(
                      child: Text(e),
                      value: e,
                    ),
                  )
                  .toList(),
              onChanged: (v) {
                patientProvider.setillnessType(v as String);
              },
            ),
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  if (illnessValueController.text.isNotEmpty ||
                      illnessController.text.isNotEmpty)
                    patientProvider.addIllnesses(
                      {
                        'المرض': illnessController.text.toString(),
                        'القيمة': illnessValueController.text.toString(),
                        'id':
                            '${(DateTime.now().second)}:${(DateTime.now().millisecond)}',
                      },
                    );
                  illnessValueController.clear();
                  illnessController.clear();
                },
                icon: const Icon(
                  Icons.add,
                  color: Colors.green,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: IllnessTextField(
                  controller: illnessController,
                  textInputAction: TextInputAction.next,
                  label: 'المرض',
                  save: (v) {},
                  validate: (v) {},
                  multiline: false),
            ),
            Expanded(
              flex: 2,
              child: IllnessTextField(
                  controller: illnessValueController,
                  textInputAction: TextInputAction.next,
                  textInputType: TextInputType.number,
                  label: 'القيمة',
                  save: (v) {},
                  validate: (v) {},
                  multiline: false),
            ),
          ],
        ),
      ),
      ...patientProvider.illnesses
          .map(
            (e) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: ListTile(
                onLongPress: () {
                  patientProvider.removeIllness(e);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(width: 1, color: Colors.greenAccent)),
                leading: Text(
                  '${e['المرض']}:',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Text(
                  '${e['القيمة']}',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          )
          .toList(),
    ]);
  }
}
