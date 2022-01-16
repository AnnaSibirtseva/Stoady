import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;

  const RoundedInputField({
    required this.hintText,
    this.icon = Icons.email_outlined,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextField(
        onChanged: onChanged,
        cursorColor:  Colors.teal,
        decoration: InputDecoration(
          icon: Icon(
            icon,
            color: Colors.black38,
          ),
          hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}