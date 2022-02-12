import 'package:flutter/material.dart';


class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final bool isSmall;

  const TextFieldContainer({
    Key? key,
    required this.child,
    required this.isSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding:
          EdgeInsets.symmetric(horizontal: 20, vertical: isSmall ? 0.7 : 5),
      width: isSmall ? size.width * 0.6 : size.width * 0.8,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.teal)),
      child: child,
    );
  }
}
