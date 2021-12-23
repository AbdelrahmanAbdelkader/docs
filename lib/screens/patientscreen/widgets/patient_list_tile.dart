import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/patient.dart';

class PatientListTile extends StatefulWidget {
  PatientListTile({
    Key? key,
  }) : super(key: key);

  @override
  State<PatientListTile> createState() => _PatientListTileState();
}

class _PatientListTileState extends State<PatientListTile> {
  bool openDetails = false;
  late Timestamp time;

  @override
  Widget build(BuildContext context) {
    final prove = Provider.of<Patient>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: (prove.doctor.isNotEmpty)
            ? Colors.cyan[200]
            : Colors.redAccent[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(prove.name),
                      Text(prove.date),
                    ],
                  ),
                  Text(prove.phone),
                  Text(prove.vol),
                ],
              ),
              if (openDetails == true)
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Divider(),
                    Text(prove.source),
                    Text(prove.address),
                    if (prove.latest != '') Text(prove.latest),
                    ...List.generate(prove.ill.length, (index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(prove.ill.keys.elementAt(index)),
                          Text((prove.ill.values.elementAt(index)
                              as Map)['name']),
                          Text((prove.ill.values.elementAt(index)
                              as Map)['value']),
                        ],
                      );
                    })
                  ],
                ),
              IconButton(
                onPressed: () {
                  setState(() {
                    openDetails = !openDetails;
                  });
                },
                icon: (!openDetails)
                    ? const Icon(Icons.arrow_drop_down)
                    : const Icon(Icons.arrow_drop_up),
              )
            ],
          ),
        ),
      ),
    );
  }
}
