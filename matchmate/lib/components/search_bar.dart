import 'package:flutter/material.dart';
import 'package:matchmate/components/textfield.dart';
import 'constants.dart';

class Searchbar extends StatelessWidget {
  Searchbar({required this.searchController, required this.onSearchChanged});

  final TextEditingController searchController;
  final Function(String) onSearchChanged;

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
              
            },
          ),
          Expanded(
            child: Container(
                height: 50,
                child: ReusableTextField(
                    null, false, searchController, 'Search Your Mate...', onSearchChanged)),
          ),
        ],
      ),
    );
  }
}
