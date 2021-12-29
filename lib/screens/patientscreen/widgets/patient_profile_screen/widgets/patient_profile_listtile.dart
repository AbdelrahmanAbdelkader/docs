import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/provider/patient.dart';

class PatientProfieListTile extends StatelessWidget {
  const PatientProfieListTile(
      {Key? key,
      required this.title,
      required this.trailing,
      required this.editFunction})
      : super(key: key);
  final String? title;
  final String? trailing;
  final Function? editFunction;
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<Account>(context);
    final patient = Provider.of<Patient>(context);
    return ListTile(
      leading: (patient.volId == account.id ||
              account.role == 'متطوع غني' ||
              account.role == 'مسؤول أبحاث')
          ? IconButton(
              onPressed: () => editFunction!(),
              icon: Icon(
                Icons.edit,
                color: Colors.white,
              ),
            )
          : null,
      title: Text(
        (title != null) ? title as String : '',
        style: Theme.of(context).textTheme.headline2,
      ),
      trailing: Text(
        (trailing != null) ? trailing as String : '',
        style: Theme.of(context).textTheme.headline2,
      ),
    );
  }
}
