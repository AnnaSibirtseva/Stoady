import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String text;
  final VoidCallback press;
  final Color color = Colors.teal, textColor = Colors.white;
  final bool reverse, borders, isSmall;

  const RoundedButton({
    Key? key,
    required this.text,
    required this.press,
    required this.reverse,
    required this.borders,
    required this.isSmall,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // Indents top and bottom.
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: isSmall ? smallElevatedButton(context) : newElevatedButton(context)
    );
  }

  //Used:ElevatedButton as FlatButton is deprecated.
  //Here we have to apply customizations to Button by inheriting the styleFrom

  Widget newElevatedButton(BuildContext context) {
    return ElevatedButton(
      child: Text(
        text,
        style: TextStyle(
            fontSize: 30.0, fontFamily: 'Nunito', fontWeight: FontWeight.w900, color: textColor),
      ),
      style: ElevatedButton.styleFrom(
          shape: const StadiumBorder(),
          primary: color,
          side: borders
              ? const BorderSide(width: 1, color: Colors.black)
              : const BorderSide(width: 0, color: Colors.black12,),
          // Moves text in the button.
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
              fontFamily: 'Nunito',
              fontWeight: FontWeight.w700,
              color: reverse ? color : textColor),
        ),
        style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
            primary: reverse ? textColor : color,
            //todo change to screen size
            fixedSize: const Size(150, 40),
            textStyle: TextStyle(
                color: reverse ? color : textColor,
                fontSize: 15.0,
                fontWeight: FontWeight.w500)),
        onPressed: press);
  }
}
