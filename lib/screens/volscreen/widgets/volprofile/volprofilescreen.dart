import 'package:flutter/material.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/widgets/information_tile.dart';

class VolanteerProfileScreen extends StatelessWidget {
  VolanteerProfileScreen({
    Key? key,
    // required this.name,
    // required this.phone,
    // required this.email,
    // required this.type,
    // this.patients,
  }) : super(key: key);

  // final String name;
  // final String phone;
  // final String email;
  // final String type;
  Map? patients;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {},
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // InformationTile(information: name, label: 'الاسم:'),
            // InformationTile(information: phone, label: 'رقم المحمول:'),
            // InformationTile(information: email, label: 'الايميل'),
            // InformationTile(information: type, label: 'التخصص'),
            SizedBox(
              height: size.height * .3,
            ),
            (patients == null)
                ? const Text('لم يتم رفع حالات')
                : const Text('تم رفع حالات'),
          ],
        ),
      ),
    );
  }
}
