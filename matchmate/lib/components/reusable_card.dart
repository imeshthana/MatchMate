import 'package:flutter/material.dart';

class ReusableCard extends StatelessWidget {
  ReusableCard({super.key, required this.decoration, this.cardChild, this.onPress});

  BoxDecoration? decoration;
  Widget? cardChild;
  VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        margin: const EdgeInsets.all(0.0),
        padding: EdgeInsets.only(top: 10, bottom: 10),
        decoration: decoration,
        child: cardChild,
      ),
    );
  }
}

