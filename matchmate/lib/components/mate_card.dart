import 'package:flutter/material.dart';

class MateCard extends StatelessWidget {
  MateCard({required this.name, required this.image});
  String name;
  String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 125,
      child: Material(
        elevation: 5, // Adjust the shadow elevation as needed
        borderRadius:
            BorderRadius.circular(12), // Adjust the corner radius as needed
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.fill,
                height: 150,
                width: 125,
              ),
              Container(
                height: 150,
                width: 125,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.white.withOpacity(1),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 8.0,
                right: 8.0,
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 25.0,
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 7.5),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Color(0xff241468), Color(0xFFC70039)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: Text(
                    name,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
