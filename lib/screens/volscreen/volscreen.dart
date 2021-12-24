import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/vol.dart';
import 'package:sample/screens/volscreen/widgets/vollist.dart';

class VolScreen extends StatelessWidget {
  const VolScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Vols>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('المتطوعين'),
      ),
      body: 
      FutureBuilder(
          future: prove.refresh(),
          builder: (context, snap) {
            return const VolList();
          }),
    );
  }
}
