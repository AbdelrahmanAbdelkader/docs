import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/docs.dart';

// ignore: must_be_immutable
class PatientDropDown extends StatefulWidget {
  PatientDropDown({
    Key? key,
    required this.text,
    required this.value,
  }) : super(key: key);
  final String text;
  String? value;
  @override
  _PatientDropDownState createState() => _PatientDropDownState();
}

class _PatientDropDownState extends State<PatientDropDown> {
  String? value;

  @override
  Widget build(BuildContext context) {
    final doctors = Provider.of<Docs>(context).doctors;

    return Card(
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //     side: const BorderSide(width: 1, color: Colors.greenAccent)),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
        child: DropdownButton(
          // icon: Icon(
          //   Icons.arrow_drop_down_sharp,
          //   color: Colors.green,
          // ),
          isExpanded: true,
          hint: Text(
            widget.text,
            // style: TextStyle(
            //   color: Colors.green,
            //   fontSize: 16,
            //   fontWeight: FontWeight.bold,
            // ),
          ),
          value: widget.value,
          underline: Container(),
          style: TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (v) => setState(() {
            widget.value = v as String;
          }),
          items: doctors
              .map(
                (e) => DropdownMenuItem(
                  child: Text(e.name),
                  value: e.name,
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
