import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/provider/docs.dart';

import 'doc_sample.dart';

class DocSearchDelegate extends SearchDelegate {
  DocSearchDelegate(BuildContext context);
  @override
  List<Widget>? buildActions(BuildContext context) {
    IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear));
  }

  @override
  Widget? buildLeading(BuildContext context) {
    IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    final prove = Provider.of<Docs>(context).doctors;
    List<Doc> resultDoctors = [];
    for (var doc in prove) {
      if (doc.name.toLowerCase().contains(query.toLowerCase())) {
        resultDoctors.add(doc);
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: resultDoctors.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: resultDoctors[index],
          builder: (context, snapshot) {
            return DocSample();
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final prove = Provider.of<Docs>(context).doctors;
    List<Doc> resultDoctors = [];
    for (var doc in prove) {
      if (doc.name.toLowerCase().contains(query.toLowerCase())) {
        resultDoctors.add(doc);
      }
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: resultDoctors.length,
      itemBuilder: (context, index) {
        return ChangeNotifierProvider.value(
          value: resultDoctors[index],
          builder: (context, snapshot) {
            return DocSample();
          },
        );
      },
    );
  }
}
