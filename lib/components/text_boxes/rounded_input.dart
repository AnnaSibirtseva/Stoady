import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/text_field_container.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final bool isSmall;
  final ValueChanged<String> onChanged;

  RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required this.isSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      isSmall: isSmall,
      child: TextField(
        onChanged: onChanged,
        cursorColor:  Colors.teal,
        decoration: InputDecoration(
          icon: isSmall ? null : Icon(
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