import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/volanteers.dart';
import 'package:sample/screens/volscreen/widgets/vollisttile.dart';

class VolList extends StatelessWidget {
  const VolList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final volanteers = Provider.of<Volanteers>(context);
    return ListView(
        children: volanteers.vols
            .map((e) => VolListTile(
                  volanteer: e,
                ))
            .toList());
  }
}
