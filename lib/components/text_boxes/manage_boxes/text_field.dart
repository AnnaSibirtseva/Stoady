import 'package:flutter/material.dart';


class TextFieldManagerContainer extends StatelessWidget {
  final Widget child;
  final bool isBig;

  const TextFieldManagerContainer({
    Key? key,
    required this.child,
    required this.isBig,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      padding: const
      EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      width: size.width * 0.9,
      height: isBig ? size.height * 0.31 : size.height * 0.13,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
              color: Colors.teal)),
      child: child,
    );
  }
}
