import 'package:flutter/material.dart';

const kColor1 = Color(0xff241468);
const kColor2 = Color(0xFFC70039);

const kColor3 = Color.fromRGBO(36, 20, 104, 0.6);
const kColor5 = Color.fromRGBO(36, 20, 104, 0.8);
const kColor4 = Color.fromRGBO(199, 0, 57, 0.8);

LinearGradient gradient = LinearGradient(
  begin: Alignment.topCenter,
  end: Alignment.bottomCenter,
  colors: [kColor1, kColor2],
  tileMode: TileMode.clamp,
);

TextStyle textStyle = TextStyle(
  color: Color.fromRGBO(36, 20, 104, 0.6),
  fontSize: 15,
  fontWeight: FontWeight.w700,
);

TextStyle tabBartextStyle = TextStyle(
  color: Color.fromRGBO(36, 20, 104, 0.6),
  fontSize: 15,
  fontWeight: FontWeight.w700,
);

TextStyle hintTextStyle = TextStyle(
  color: Color.fromRGBO(36, 20, 104, 0.4),
  fontSize: 15,
  fontWeight: FontWeight.w700,
);
