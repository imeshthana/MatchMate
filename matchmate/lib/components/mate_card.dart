import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';

class MateCard extends StatefulWidget {
  MateCard({
    required this.name,
    required this.image,
  });
  String name;
  String image;

  @override
  State<MateCard> createState() => _MateCardState();
}

class _MateCardState extends State<MateCard> {
  bool isFavouritePressed = false;

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
              Image.network(
                widget.image,
                fit: BoxFit.fill,
                height: 175,
                width: 150,
              ),
              Container(
                height: 175,
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
              Container(
                alignment: Alignment.bottomCenter,
                padding: EdgeInsets.only(bottom: 7.5),
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return gradient.createShader(bounds);
                  },
                  child: Text(
                    widget.name,
                    style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
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
