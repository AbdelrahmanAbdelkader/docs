import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/vol.dart';
import 'package:sample/screens/volscreen/widgets/vollisttile.dart';

class VolList extends StatelessWidget {
  const VolList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final vol = Provider.of<Vols>(context);
    return ListView(children: [
      ...vol.volsPharm
          .map(
            (e) => VolListTile(
              name: e['userName'] as String,
              phone: e['phone'] as String,
              type: e['state'] as String,
              accepted: e['accepted'],
              email: e['email'],
              id: e['id'],
              uid: e['uid'],
            ),
          )
          .toList(),
      ...vol.volsChem
          .map(
            (e) => VolListTile(
              name: e['userName'] as String,
              phone: e['phone'] as String,
              type: e['state'] as String,
              accepted: e['accepted'],
              email: e['email'],
              id: e['id'],
              uid: e['uid'],
            ),
          )
          .toList(),
    ]);
  }
}
