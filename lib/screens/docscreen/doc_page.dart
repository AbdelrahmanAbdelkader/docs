import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/screens/widgets/app_bar_button.dart';

import 'package:sample/screens/docscreen/getAddDocProvited.dart';
import 'package:sample/screens/docscreen/widgets/search.dart';
import '../widgets/search_button.dart';
import 'widgets/doc_sample.dart';

class DocList extends StatefulWidget {
  const DocList({Key? key}) : super(key: key);

  @override
  State<DocList> createState() => _DocListState();
}

class _DocListState extends State<DocList> {
  void settingState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Docs>(context, listen: false);
    final proveTrue = Provider.of<Docs>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('الدكاترة'),
        actions: [
          IconButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            icon: Icon(Icons.logout),
          ),
          IconButton(
              onPressed: () {
                showSearch(
                    context: context, delegate: DocSearchDelegate(context));
              },
              icon: Icon(Icons.search)),
          AppBarButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => GetAddDocProve(settingState),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: size.height,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.fill,
                width: size.width,
              ),
            ),
            LayoutBuilder(builder: (context, cons) {
              return FutureBuilder(
                  future: prove.refresh(),
                  builder: (cont, snap) {
                    if (snap.connectionState == ConnectionState.waiting)
                      return Container(
                          height: cons.maxHeight,
                          child:
                              Center(child: const CircularProgressIndicator()));
                    if (proveTrue.doctors.isNotEmpty)
                      return SingleChildScrollView(
                        child: Column(
                          children: List.generate(
                            proveTrue.doctors.length,
                            (index) {
                              return ChangeNotifierProvider.value(
                                value: proveTrue.doctors[index],
                                builder: (context, snapshot) {
                                  return DocSample();
                                },
                              );
                            },
                          ).toList(),
                        ),
                      );
                    return Container(
                      height: cons.maxHeight,
                      child: Center(child: Text('لا توجد دكاتره')),
                    );
                  });
            }),
          ],
        ),
      ),
    );
  }
}
