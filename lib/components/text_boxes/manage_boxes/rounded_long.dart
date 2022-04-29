import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/manage_boxes/text_field.dart';

class RoundedInputTextField extends StatelessWidget {
  final bool isBig;
  final bool isQuestion;
  final String hintText;
  final String initialValue;
  final ValueChanged<String> onChanged;

  const RoundedInputTextField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.isBig,
    required this.initialValue,
    required this.isQuestion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldManagerContainer(
      isBig: isBig,
      isQuestion: isQuestion,
      child: TextFormField(
        keyboardType: TextInputType.multiline,
        textAlign: TextAlign.left,//Alignment.topLeft,
        expands: isBig ? true : false,
        initialValue: initialValue,
        maxLines: null,
        minLines: null,
        maxLength: isQuestion ? 100 : isBig ? 250 : 50,
        onChanged: onChanged,
        cursorColor: Colors.teal,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(9),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}
