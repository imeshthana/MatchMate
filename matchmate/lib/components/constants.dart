import 'package:flutter/material.dart';

const kColor1 = Color(0xff241468);
const kColor2 = Color(0xFFC70039);

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

TextStyle hintTextStyle = TextStyle(
  color: Color.fromRGBO(36, 20, 104, 0.4),
  fontSize: 15,
  fontWeight: FontWeight.w700,
);