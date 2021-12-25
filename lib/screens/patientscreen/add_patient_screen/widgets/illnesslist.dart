import 'package:flutter/material.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/state_dropdownbutton.dart';

import 'illness.dart';
import 'illnesstextfield.dart';

class IllnessList extends StatefulWidget {
  const IllnessList(
      {Key? key,
      required this.illnessController,
      required this.illnessValueController})
      : super(key: key);
  final TextEditingController illnessController;
  final TextEditingController illnessValueController;
  @override
  _IllnessListState createState() => _IllnessListState();
}

class _IllnessListState extends State<IllnessList> {
  List<Map> illnesses = [];
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      StateDropDownButton(label: 'تخصص المرض', items: speciality),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: IconButton(
                onPressed: () {
                  print(illnesses);
                  setState(
                    () {
                      if (widget.illnessValueController.text.isNotEmpty ||
                          widget.illnessController.text.isNotEmpty)
                        illnesses.add(
                          {
                            'المرض': widget.illnessController.text.toString(),
                            'القيمة':
                                widget.illnessValueController.text.toString(),
                          },
                        );
                      widget.illnessValueController.clear();
                      widget.illnessController.clear();
                    },
                  );
                  print(illnesses);
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
                  controller: widget.illnessController,
                  label: 'المرض',
                  save: (v) {},
                  validate: (v) {},
                  multiline: false),
            ),
            Expanded(
              flex: 2,
              child: IllnessTextField(
                  controller: widget.illnessValueController,
                  label: 'القيمة',
                  save: (v) {},
                  validate: (v) {},
                  multiline: false),
            ),
          ],
        ),
      ),
      ...illnesses
          .map(
            (e) => Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: ListTile(
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
