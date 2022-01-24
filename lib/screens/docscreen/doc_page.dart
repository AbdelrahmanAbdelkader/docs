import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/provider/docs.dart';
import 'package:sample/screens/widgets/app_bar_button.dart';
import 'package:sizer/sizer.dart';
import 'package:sample/screens/docscreen/getAddDocProvited.dart';
import 'widgets/doc_sample.dart';

class DocList extends StatefulWidget {
  const DocList(this.refresh, {Key? key}) : super(key: key);
  final Function refresh;
  @override
  State<DocList> createState() => _DocListState();
}

class _DocListState extends State<DocList> {
  List<Doc> searchedDoctors = [];
  bool search = false;

  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Docs>(context, listen: false);
    final proveTrue = Provider.of<Docs>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text((search) ? 'البحث' : 'الدكاترة'),
        actions: (search)
            ? [
                IconButton(
                    onPressed: () {
                      setState(() {
                        search = false;
                      });
                    },
                    icon: Icon(Icons.arrow_back))
              ]
            : [
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
                      builder: (context) => GetAddDocProve(widget.refresh),
                    ),
                  ),
                ),
              ],
      ),
      body: Container(
        height: 100.h,
        child: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.fill,
                width: 100.w,
              ),
            ),
            LayoutBuilder(builder: (context, cons) {
              return (proveTrue.doctors.isNotEmpty)
                  ? SingleChildScrollView(
                      child: Column(children: [
                        if (search)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 15),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.green.shade50.withOpacity(.2),
                                  borderRadius: BorderRadius.circular(15),
                                  border: Border.all(
                                      width: 1, color: Colors.green.shade400)),
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 10),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: TextFormField(
                                            onChanged: (value) {
                                              setState(() {
                                                searchedDoctors = prove.doctors
                                                    .where((element) {
                                                  return element.name
                                                      .toLowerCase()
                                                      .contains(value);
                                                }).toList();
                                              });
                                            },
                                            decoration: InputDecoration(
                                              hintText: 'اسم الدكتور',
                                              suffixIcon: Icon(
                                                Icons.search,
                                                color: Colors.green[200],
                                              ),
                                              hintStyle: TextStyle(
                                                  color: Colors.green[200]),
                                              // label: Text(label),

                                              border: InputBorder.none,
                                              errorBorder: InputBorder.none,
                                              enabledBorder: InputBorder.none,
                                              focusedBorder: InputBorder.none,
                                              disabledBorder: InputBorder.none,
                                              focusedErrorBorder:
                                                  InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
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
