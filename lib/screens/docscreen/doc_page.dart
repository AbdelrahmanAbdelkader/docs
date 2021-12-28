import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/screens/widgets/app_bar_button.dart';

import 'package:sample/screens/docscreen/getAddDocProvited.dart';
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

  List<Doc> searchedDoctors = [];
  bool search = false;
  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Docs>(context, listen: false);
    final proveTrue = Provider.of<Docs>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: (search)
          ? null
          : AppBar(
              title: const Text('الدكاترة'),
              actions: [
                IconButton(
                  onPressed: () => FirebaseAuth.instance.signOut(),
                  icon: Icon(Icons.logout),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        search = true;
                      });
                      // showSearch(
                      //     context: context, delegate: DocSearchDelegate(context));
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
              return (proveTrue.doctors.isNotEmpty)
                  ? SingleChildScrollView(
                      child: Column(children: [
                        if (search)
                          Container(
                            color: Colors.green[800],
                            child: Column(
                              children: [
                                SizedBox(
                                  height: MediaQuery.of(context).padding.top,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        onChanged: (value) {
                                          setState(() {
                                            searchedDoctors =
                                                prove.doctors.where((element) {
                                              return element.name
                                                  .contains(value);
                                            }).toList();
                                          });
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'search for doctor',
                                          hintStyle: TextStyle(
                                              color: Colors.green[100]),
                                          // label: Text(label),
                                          border: InputBorder.none,
                                          errorBorder: InputBorder.none,
                                          enabledBorder: InputBorder.none,
                                          focusedBorder: InputBorder.none,
                                          disabledBorder: InputBorder.none,
                                          focusedErrorBorder: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color: Colors.green[100],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          search = false;
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        if (!search)
                          ...List.generate(
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
                        if (search)
                          ...searchedDoctors.map(
                            (e) => ChangeNotifierProvider.value(
                              key: Key(e.Id as String),
                              value: e,
                              builder: (context, snapshot) {
                                return DocSample();
                              },
                            ),
                          ),
                      ]),
                    )
                  : Container(
                      height: cons.maxHeight,
                      child: Center(child: Text('لا توجد دكاتره')),
                    );
            }),
          ],
        ),
      ),
    );
  }
}
