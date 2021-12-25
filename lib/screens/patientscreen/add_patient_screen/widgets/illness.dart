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
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal:10.0),
      child: Row(
        children: [
          Expanded(flex: 2,
            child: IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add),
            ),
          ),
          Expanded(
            flex: 5,
            child: IllnessTextField(
                label: 'المرض', save: (v) {}, validate: (v) {}, multiline: false),
          ),
          Expanded(
            flex: 2,
            child: IllnessTextField(
                label: 'القيمة',
                save: (v) {},
                validate: (v) {},
                multiline: false),
          ),
        ],
      ),
    );
  }
}
