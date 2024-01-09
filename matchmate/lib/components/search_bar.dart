import 'package:flutter/material.dart';
import 'package:matchmate/components/textfield.dart';
import 'constants.dart';

class Searchbar extends StatelessWidget {
  const Searchbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: ShaderMask(
              shaderCallback: (Rect bounds) {
                return gradient.createShader(bounds);
              },
              child: Icon(
                Icons.search,
                size: 30.0,
                color: kColor2,
              ),
            ),
            onPressed: () {
              // Handle the onPressed event for the search icon
            },
          ),
          Expanded(
            child: Container(
                height: 50,
                child: ReusableTextField(
                    null, false, null, 'Search Your Mate...')),
          ),
        ],
      ),
    );
  }
}
