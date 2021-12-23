import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/screens/docscreen/add_doc.dart';

class GetAddDocProve extends StatelessWidget {
  GetAddDocProve(this.fun, {Key? key}) : super(key: key);
  late final Doc doc;
  final Function fun;
  @override
  Widget build(BuildContext context) {
    doc = Doc()..ref = fun;
    return ChangeNotifierProvider.value(value: doc, child: AddDoctor());
  }
}
