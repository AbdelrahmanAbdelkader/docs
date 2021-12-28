import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/docs.dart';

import 'doc_page.dart';

class GetDoctorsData extends StatefulWidget {
  const GetDoctorsData({Key? key}) : super(key: key);
  @override
  State<GetDoctorsData> createState() => _GetDoctorsDataState();
}

class _GetDoctorsDataState extends State<GetDoctorsData> {
  void settingState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Docs>(context, listen: false);
    return FutureBuilder(
        future: prove.refresh(settingState),
        builder: (cont, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(
                child: Center(child: const CircularProgressIndicator()));
          return DocList(settingState);
        });
  }
}
