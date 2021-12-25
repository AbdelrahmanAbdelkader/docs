import 'package:flutter/material.dart';

class IllnessTextField extends StatelessWidget {
  const IllnessTextField({
    Key? key,
    required this.label,
    required this.save,
    required this.validate,
    required this.multiline,
  }) : super(key: key);
  final String label;

  final Function save;
  final Function validate;
  final bool multiline;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(width: 1, color: Colors.greenAccent),
      ),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: TextFormField(
          maxLines: (multiline) ? 3 : 1,
          decoration: InputDecoration(
          
            label: Text(label),
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
