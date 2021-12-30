import 'package:flutter/material.dart';
import 'package:sample/provider/volanteer.dart';
import 'package:sample/screens/volscreen/widgets/volprofile/widgets/information_tile.dart';

class VolanteerProfileScreen extends StatelessWidget {
  VolanteerProfileScreen(
    this.volanteer, {
    Key? key,

    // this.patients,
  }) : super(key: key);
  Volanteer volanteer;
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
            InformationTile(
                information: volanteer.name as String, label: 'الاسم:'),
            InformationTile(
                information: volanteer.phone as String, label: 'رقم المحمول:'),
            InformationTile(
                information: volanteer.email as String, label: 'الايميل'),
            SizedBox(
              height: size.height * .3,
            ),
            (volanteer.patients == [])
                ? const Text('لم يتم رفع حالات')
                : const Text('تم رفع حالات'),
          ],
        ),
      ),
    );
  }
}
