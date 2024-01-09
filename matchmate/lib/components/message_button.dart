import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';

class MessageButton extends StatelessWidget {
  MessageButton({super.key, this.cardChild, this.onPress});

  Widget? cardChild;
  VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPress,
      backgroundColor: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // Use a Container to apply gradient background
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: cardChild, // Icon goes here
        padding: EdgeInsets.all(16.0), // Adjust padding as needed
      ),
    );
  }
}
