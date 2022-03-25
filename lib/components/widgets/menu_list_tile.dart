import 'package:flutter/material.dart';

class MenuListTile extends StatelessWidget {
  final VoidCallback press;
  final String text;
  final IconData icon;
  final bool canClick;

  const MenuListTile(
      {Key? key,
      required this.press,
      required this.text,
      required this.icon,
      required this.canClick})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          Icon(icon, size: 35, color: canClick ? Colors.black : Colors.black26),
      title: Text(text,
          style: TextStyle(
              fontSize: 20.0,
              color: canClick ? Colors.black : Colors.black26,
              fontWeight: FontWeight.w700)),
      onTap: press,
    );
  }
}
