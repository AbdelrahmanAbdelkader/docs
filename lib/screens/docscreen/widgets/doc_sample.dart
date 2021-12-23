import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/doc.dart';
import 'package:sample/screens/docscreen/add_doc.dart';

class DocSample extends StatefulWidget {
  DocSample({Key? key});

  @override
  State<DocSample> createState() => _DocSampleState();
}

class _DocSampleState extends State<DocSample> {
  bool toggled = false;
  late final String docName;
  late final String id;
  late final String? docNum;
  late final String? docEmail;
  late final String docType;
  late final bool agreed;
  late final String? hint;
  late final List<Map>? patients;
  late final Doc prove;
  bool _once = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_once) {
      prove = Provider.of<Doc>(context);
      docName = prove.name;
      id = prove.Id as String;
      docNum = prove.phone;
      docEmail = prove.email;
      docType = prove.type as String;
      agreed = prove.agreed;
      hint = prove.hint;
      patients = prove.patients;
      _once = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceOut,
      margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: (agreed) ? Colors.blue[300] : Colors.red[300],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      docName,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      docType,
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${(docEmail != null) ? docEmail : docNum}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (ctx) => AddDoctor(),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 22,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          if (hint != '' && toggled)
            Text(
              hint as String,
              style: const TextStyle(
                fontSize: 18,
                color: Colors.white,
              ),
            ),
          if (patients != null && toggled)
            Column(
              children: patients!
                  .map((e) => Container(
                        color: Colors.green[800],
                        child: Row(
                          children: [
                            Text(
                              e['name'] as String,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              e['illness'],
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
          if (hint != '' || patients!.isEmpty)
            IconButton(
              onPressed: () {
                setState(() {
                  toggled = !toggled;
                });
              },
              splashRadius: 0.1,
              padding: EdgeInsets.zero,
              icon: (!toggled)
                  ? const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.arrow_drop_up,
                      color: Colors.white,
                    ),
            )
        ],
      ),
    );
  }
}
