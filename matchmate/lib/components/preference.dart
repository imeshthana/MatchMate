import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';

class Preference extends StatelessWidget {
  Preference({required this.preference});

  final String preference;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(
        preference,
        style: TextStyle(
            fontWeight: FontWeight.w700, color: Colors.white, fontSize: 17.5),
      ),
      decoration: BoxDecoration(
        color: kColor4,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(5),
    );
  }
}
