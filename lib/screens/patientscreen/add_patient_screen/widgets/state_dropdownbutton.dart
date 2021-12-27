import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/helpers/data_lists.dart';
import 'package:sample/provider/state.dart';

class StateDropDownButton extends StatefulWidget {
  const StateDropDownButton({
    Key? key,
    required this.label,
    required this.items,
  }) : super(key: key);

  final String label;
  final List items;
  @override
  _StateDropDownButtonState createState() => _StateDropDownButtonState();
}

class _StateDropDownButtonState extends State<StateDropDownButton> {
  String? value;
  @override
  Widget build(BuildContext context) {
    return Padding(
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
              widget.label,
              
            ),
            value: value,
            items: widget.items
                .map(
                  (e) => DropdownMenuItem(
                    child: Text(e),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (v) {
              setState(() {
                value = v as String;
              });
              if (widget.items == states) {
                Provider.of<StateManagment>(context, listen: false)
                    .setPatientVillageDropDownButtonValue(v as String);
              } else {
                Provider.of<StateManagment>(context, listen: false)
                    .setPatientIllnessTypeDropDownButtonValue(v as String);
              }
            },
          ),
        ),
      ),
    );
  }
}
