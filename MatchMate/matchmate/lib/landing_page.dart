import 'package:flutter/material.dart';
import 'create_account.dart';
import 'components/main_button.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            alignment: Alignment.bottomCenter,
            child: ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xff241468), Color(0xFFC70039)],
                ).createShader(bounds);
              },
              child: Text(
                "MatchMate",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors
                      .white, // Set text color to white or any color that contrasts with the gradient
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Image.asset(
            "assets/1.jpg",
            height: 370,
          ),
          SizedBox(height: 100),

          MainButton(
            text: 'Get Started',
            onPress: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => CreateAccount()));
            },
          ),

          SizedBox(height: 20),

          Container(
            alignment: Alignment.topCenter,
            child: Text(
              "Already have an account",
              style: TextStyle(
                color: Color(0xff241468),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          // SizedBox(height: 5),

          Container(
            child: Center(
              child: TextButton(
                onPressed: () {
                  // Your button click logic here
                },
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      colors: [Color(0xff241468), Color(0xFFC70039)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ).createShader(bounds);
                  },
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Text color
                    ),
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

