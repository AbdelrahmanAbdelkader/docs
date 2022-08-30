import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:sample/provider/patients/patients.dart';
import 'package:sample/screens/patientscreen/widgets/patient_list_tile.dart';

class PatientList extends StatelessWidget {
  const PatientList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //final account = Provider.of<Account>(context);
    return FutureBuilder(
      future: context.read<PatientsProv>().refresh(context),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (context.watch<PatientsProv>().patients.isNotEmpty) {
          return ListView(
            children: context
                .watch<PatientsProv>()
                .patients
                .map((e) => ChangeNotifierProvider.value(
                      value: e,
                      child: PatientListTile(),
                    ))
                .toList(),
          );
        }
        return const Center(
          child: Text('لا توجد حالات'),
        );
      },
    );
  }
}
