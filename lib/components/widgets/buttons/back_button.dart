// import 'package:flutter/material.dart';
//
// class BackButton extends StatelessWidget {
//   final VoidCallback press;
//
//   const BackButton({
//     required this.press,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Container(
//       margin: const EdgeInsets.symmetric(vertical: 10),
//       child: ClipRRect(
//         child: newElevatedButton(context),
//       ),
//     );
//   }
//
//   //Used:ElevatedButton as FlatButton is deprecated.
//   //Here we have to apply customizations to Button by inheriting the styleFrom
//
//   Widget newElevatedButton(BuildContext context) {
//     return ElevatedButton(
//       child: const Text(
//         "Back",
//         style: TextStyle(
//             fontSize: 17.0,
//             fontWeight: FontWeight.w700,
//             fontFamily: "Montserrat",
//             color: Colors.black),
//       ),
//       style: ElevatedButton.styleFrom(
//           primary: Colors.white,
//           padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
//           textStyle: const TextStyle(
//               color: Colors.black, fontSize: 17.0, fontWeight: FontWeight.w500)),
//       onPressed: press,
//     );
//   }
// }
