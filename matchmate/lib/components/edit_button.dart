import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';

class EditButton extends StatelessWidget {
  EditButton({super.key, this.cardChild, this.onPress});

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
      child: Container(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: cardChild, 
        padding: EdgeInsets.all(16.0), 
      ),
    );
  }
}
