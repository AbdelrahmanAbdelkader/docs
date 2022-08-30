import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample/provider/docs/docs.dart';
import 'package:sample/provider/patients/patients.dart';

import 'doc_page.dart';

class GetDoctorsData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: context.watch<Docs>().refresh(
              context,
            ),
        builder: (cont, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            print('loading reresh docsController with indicator');
            return Center(
                child: Center(child: const CircularProgressIndicator()));
          }
          return DocList();
        });
  }
}
