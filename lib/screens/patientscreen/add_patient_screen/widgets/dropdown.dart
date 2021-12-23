import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropDown extends StatefulWidget {
  DropDown({
    Key? key,
    required this.text,
    required this.path,
    required this.value,
  }) : super(key: key);
  final String text;
  final String path;
  String? value;
  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  String? value;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection(widget.path).get().asStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  side: const BorderSide(width: 1, color: Colors.greenAccent)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: DropdownButton(
                  isDense: true,
                  hint: Text(widget.text),
                  value: widget.value,
                  underline: Container(),
                  onChanged: (v) => setState(() {
                    widget.value = v as String;
                  }),
                  items: snapshot.data!.docs.map((DocumentSnapshot document) {
                    final Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return DropdownMenuItem(
                      child: Text(data['name'] as String),
                      value: data['id'],
                    );
                  }).toList(),
                ),
              ),
            );
          }
          return Container();
        });
  }
}
