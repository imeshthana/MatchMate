import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';

class MateCard extends StatelessWidget {
  MateCard(
      {required this.name,
      required this.image,
      required this.onFavouritePressed});
  String name;
  String image;
  VoidCallback? onFavouritePressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 150,
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              Image.asset(
                image,
                fit: BoxFit.fill,
                height: 150,
                width: 150,
              ),
              Container(
                height: 150,
                width: 150,
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
                child: IconButton(
                  onPressed: onFavouritePressed,
                  icon: Icon(
                    Icons.favorite,
                    color: Colors.white,
                    size: 25.0,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 7.5),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return gradient.createShader(bounds);
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
