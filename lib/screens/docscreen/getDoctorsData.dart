import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/docs.dart';

import 'doc_page.dart';

class GetDoctorsData extends StatelessWidget {
  const GetDoctorsData({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Docs>(context, listen: false);
    return FutureBuilder(
        future: prove.refresh(),
        builder: (cont, snap) {
          if (snap.connectionState == ConnectionState.waiting)
            return Center(
                child: Center(child: const CircularProgressIndicator()));
          return DocList();
        });
  }
}
