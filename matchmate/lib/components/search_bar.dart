import 'package:flutter/material.dart';
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
                color: Color(0xFFC70039), // Adjust the size as needed
              ),
            ),
            onPressed: () {
              // Handle the onPressed event for the search icon
            },
          ),
          Expanded(
            child: Container(
              height: 50,
              child: TextField(
                textAlign: TextAlign.left,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2.0, // Set the desired border width when focused
                      color: Color(
                          0xFFC70039), // Set the desired border color when focused
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(
                      width: 2.0, // Set the desired border width
                      // Use LinearGradient for a gradient border
                      color: Color(0xff241468),
                    ),
                  ),
                  labelText: null,
                  hintText: 'Search Your Mate...',
                  hintStyle: TextStyle(
                    color: Color.fromRGBO(36, 20, 104, 0.6),
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
