import 'package:flutter/material.dart';

// ignore: must_be_immutable
class VolListTile extends StatelessWidget {
  VolListTile({
    Key? key,
    required this.name,
    required this.phone,
    required this.state,
    required this.id,
    this.patients,
  }) : super(key: key);
  final String name;
  final String phone;
  final String state;
  final String id;
  Map<String, Object>? patients;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      tileColor: Colors.blue[300],
      leading: CircleAvatar(
        child: Text(
          name[0],
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      title: Text(
        name,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      subtitle: Text(
        phone,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
    );
  }
}
