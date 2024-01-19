import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/screens/login.dart';
import '../components/main_button.dart';
import 'create_account.dart';

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
                return gradient.createShader(bounds);
              },
              child: const Text(
                "MatchMate",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 30),

          Image.asset(
            "assets/logo.jpg",
            height: MediaQuery.of(context).size.height * 0.45,
            width: MediaQuery.of(context).size.width * 0.95,
          ),

          const SizedBox(height: 60),

          MainButton(
            text: 'Get Started',
            onPress: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const CreateAccount()));
            },
          ),

           SizedBox(height: MediaQuery.of(context).size.height * 0.02
            ),

          Container(
            alignment: Alignment.topCenter,
            child: Text(
              "Already have an account",
              style: textStyle,
            ),
          ),

          // SizedBox(height: 5),

          Center(
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const Login()));
              },
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return gradient.createShader(bounds);
                },
                child: const Text(
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
        ],
      ),
    );
  }
}
