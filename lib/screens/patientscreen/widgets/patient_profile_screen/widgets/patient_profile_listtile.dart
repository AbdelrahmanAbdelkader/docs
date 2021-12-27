import 'package:flutter/material.dart';

class PatientProfieListTile extends StatelessWidget {
  const PatientProfieListTile(
      {Key? key, required this.title, required this.trailing})
      : super(key: key);
  final String? title;
  final String? trailing;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
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
