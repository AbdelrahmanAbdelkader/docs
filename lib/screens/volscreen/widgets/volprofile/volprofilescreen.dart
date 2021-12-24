import 'package:flutter/material.dart';

class VolanteerProfileScreen extends StatelessWidget {
  VolanteerProfileScreen({
    Key? key,
    required this.name,
    required this.phone,
    required this.email,
    required this.type,
    this.patients,
  }) : super(key: key);

  final String name;
  final String phone;
  final String email;
  final String type;
  Map? patients;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [const Text(':الاسم'), Text(name)],
          ),
          Row(
            children: [const Text(':رقم التلفون'), Text(phone)],
          ),
          Row(
            children: [const Text(':الايميل'), Text(email)],
          ),
          Row(
            children: [const Text('التخصص'), Text(type)],
          ),
          SizedBox(
            height: size.height * .3,
          ),
          (patients == null)
              ? const Text('لم يتم رفع حالات')
              : const Text('تم رفع حالات'),
        ],
      ),
    );
  }
}
