import 'package:flutter/material.dart';
import 'package:stoady/components/text_boxes/text_field_container.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;

  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      isSmall: false,
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        cursorColor: Colors.teal,
        decoration: const InputDecoration(
          hintText: "Password",
          icon: Icon(
            Icons.lock_outline_rounded,
            color: Colors.black38,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}