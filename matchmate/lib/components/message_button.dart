import 'package:flutter/material.dart';

class MessageButton extends StatelessWidget {
  const MessageButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: Colors.transparent,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      // Use a Container to apply gradient background
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff241468), Color(0xFFC70039)],
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Icon(Icons.message), // Icon goes here
        padding: EdgeInsets.all(16.0), // Adjust padding as needed
      ),
    );
  }
}
