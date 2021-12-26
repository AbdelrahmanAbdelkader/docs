import 'package:flutter/material.dart';

class IllnessTextField extends StatelessWidget {
  const IllnessTextField({
    Key? key,
    required this.label,
    required this.save,
    required this.validate,
    required this.multiline,
    required this.controller,
  }) : super(key: key);
  final String label;

  final Function save;
  final Function validate;
  final bool multiline;
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return Card(
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(10),
      //   side: const BorderSide(width: 1, color: Colors.greenAccent),
      // ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          style: TextStyle(
            color: Colors.green,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          controller: controller,
          maxLines: (multiline) ? 3 : 1,
          decoration: InputDecoration(
            label: Text(
              label,
              // style: TextStyle(
              //   color: Colors.green,
              //   fontSize: 16,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
            border: InputBorder.none,
            errorBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            disabledBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
          ),
          validator: (v) => validate(v),
          onSaved: (v) => save(v),
        ),
      ),
    );
  }
}
