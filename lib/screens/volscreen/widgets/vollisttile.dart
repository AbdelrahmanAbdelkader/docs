import 'package:flutter/material.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/volprofilescreen.dart';

// ignore: must_be_immutable
class VolListTile extends StatelessWidget {
  VolListTile({
    Key? key,
    required this.name,
    required this.phone,
    required this.type,
    required this.id,
    required this.accepted,
    required this.email,
    this.patients,
  }) : super(key: key);
  final String name;
  final String phone;
  final String type;
  final String id;
  final bool accepted;
  final String email;
  Map<String, Object>? patients;
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
                name: name,
                phone: phone,
                email: email,
                type: type,
                patients: patients,
              ),
            ),
          );
        },
        tileColor: (accepted) ? Colors.blue[300] : Colors.red[300],
        leading: IconButton(
          onPressed: () {},
          icon: (accepted)
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
              name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Text(
              type,
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
            phone,
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
