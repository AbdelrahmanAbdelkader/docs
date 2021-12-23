import 'package:flutter/material.dart';
import 'package:sample/screens/patientscreen/add_patient_screen/widgets/illnesstextfield.dart';

class Ilness extends StatelessWidget {
  const Ilness({
    Key? key,
    required this.illnessController,
    required this.illnessValueController,
  }) : super(key: key);
  final TextEditingController illnessController;
  final TextEditingController illnessValueController;
  final illnessKey = UniqueKey;
  final illnessValueKey = UniqueKey;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.add),
        ),
        SizedBox(
          width: size.width * .5,
          child: IllnessTextField(
              label: 'المرض', save: (v) {}, validate: (v) {}, multiline: false),
        ),
        SizedBox(
          width: size.width * .3,
          child: IllnessTextField(
              label: 'القيمة',
              save: (v) {},
              validate: (v) {},
              multiline: false),
        ),
      ],
    );
  }
}
