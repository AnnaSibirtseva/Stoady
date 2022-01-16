import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color = Colors.teal, textColor = Colors.white;
  final bool reverse, borders, isSmall;

  const RoundedButton({
    required this.text,
    required this.press,
    required this.reverse,
    required this.borders,
    required this.isSmall,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child:
            isSmall ? smallElevatedButton(context) : newElevatedButton(context),
      ),
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.w900,
            fontFamily: "Montserrat",
            color: textColor),
      ),
      style: ElevatedButton.styleFrom(
          primary: color,
          side: borders
              ? const BorderSide(width: 1, color: Colors.black)
              : const BorderSide(width: 0, color: Colors.black),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          textStyle: TextStyle(
              color: textColor, fontSize: 15.0, fontWeight: FontWeight.w500)),
      onPressed: press,
    );
  }

  Widget smallElevatedButton(BuildContext context) {
    return ElevatedButton(
        child: Text(
          text,
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
              fontFamily: "Montserrat",
              color: reverse ? color : textColor),
        ),
        style: ElevatedButton.styleFrom(
            primary: reverse ? textColor : color,
            fixedSize: const Size(150, 40),
            //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            textStyle: TextStyle(
                color: reverse ? color : textColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w500)),
        onPressed: press);
  }
}
