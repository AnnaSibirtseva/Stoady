import 'package:flutter/material.dart';

class MenuListTile extends StatelessWidget {
  final VoidCallback press;
  final String text;
  final IconData icon;

  const MenuListTile(
      {Key? key, required this.press, required this.text, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 35, color: Colors.black),
      title: Text(text,
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700)),
      onTap: press,
    );
  }
}
