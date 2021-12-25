import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/volprofilescreen.dart';

// ignore: must_be_immutable
class VolListTile extends StatefulWidget {
  VolListTile({
    Key? key,
    required this.name,
    required this.phone,
    required this.type,
    required this.id,
    required this.accepted,
    required this.email,
    this.patients,
    required this.uid,
  }) : super(key: key);
  final String name;
  final String phone;
  final String type;
  final String id;
  bool accepted;
  final String email;
  final String uid;
  Map<String, Object>? patients;

  @override
  State<VolListTile> createState() => _VolListTileState();
}

class _VolListTileState extends State<VolListTile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => VolanteerProfileScreen(
                name: widget.name,
                phone: widget.phone,
                email: widget.email,
                type: widget.type,
                patients: widget.patients,
              ),
            ),
          );
        },
        tileColor: (widget.accepted) ? Colors.blue[300] : Colors.red[300],
        leading: IconButton(
          onPressed: () {
            FirebaseDatabase.instance
                .ref()
                .child("activation")
                .child(widget.uid)
                .set({"accepted": !widget.accepted});
            setState(() {
              widget.accepted = !widget.accepted;
            });
          },
          icon: (widget.accepted)
              ? Icon(
                  Icons.check_box,
                  color: Colors.green,
                )
              : Icon(
                  Icons.check_box_outline_blank,
                  color: Colors.white,
                ),
        ),
        title: Column(
          children: [
            Text(
              widget.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              widget.type,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            )
          ],
        ),
        trailing: FittedBox(
          child: Text(
            widget.phone,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}
