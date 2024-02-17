import 'package:flutter/material.dart';

Color defaultColor = Colors.blue;
Color black = const Color.fromRGBO(27, 26, 34, 1);
Color white = const Color.fromRGBO(255, 255, 255, 1);
Color grey = const Color.fromRGBO(126, 126, 126, 1);
Color blackGrey = const Color.fromRGBO(28, 28, 28, 0.76);
Color backGroundColor = HexColor('F1F1F1');

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}

// LinearGradient gradient = LinearGradient(
//   // begin: Alignment.topLeft,
//   // end: Alignment.bottomRight,
//   colors: <Color>[
//     HexColor('#199A9E'),
//     HexColor('#299A9E'),
//     HexColor('#399A9E'),
//     HexColor('#499A9E'),
//     HexColor('#599A9E'),
//     HexColor('#699A9E'),
//   ],
// );
