
import 'package:flutter/material.dart';
import 'package:flutter_plus/flutter_plus.dart';

class Palette {
  static const MaterialColor kToDark = MaterialColor(
    0xFF2D55A1,
    <int, Color>{
      50: Color.fromRGBO(45, 86, 161, .1),
      100: Color.fromRGBO(45, 86, 161, .2),
      200: Color.fromRGBO(45, 86, 161, .3),
      300: Color.fromRGBO(45, 86, 161, .4),
      400: Color.fromRGBO(45, 86, 161, .5),
      500: Color.fromRGBO(45, 86, 161, .6),
      600: Color.fromRGBO(45, 86, 161, .7),
      700: Color.fromRGBO(45, 86, 161, .8),
      800: Color.fromRGBO(45, 86, 161, .9),
      900: Color.fromRGBO(45, 86, 161, 1),
    },
  );
}

class CustomColors {
  static final azul = utilsPlus.colorHex('#2D55A1');
}