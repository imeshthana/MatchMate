import 'dart:io';

import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/screens/login.dart';
import '../components/main_button.dart';
import 'create_account.dart';

class LandingPage extends StatelessWidget {
  static String id = 'landing';

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

          Hero(
            tag: 'logo',
            child: Image.asset(
              "assets/logo.jpg",
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width * 0.95,
            ),
          ),

          const SizedBox(height: 60),

          MainButton(
            text: 'Get Started',
            // onPress: () {

            // },
            onPress: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    actions: [
                      TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(80.0, 40.0),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kColor4),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                         exit(0);
                        },
                        child: Text(
                          'No',
                        ),
                      ),
                      TextButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(80.0, 40.0),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(kColor4),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const CreateAccount()));
                        },
                        child: Text(
                          'Yes',
                        ),
                      ),
                    ],
                    title: Center(
                      child: Text(
                        'DISCLAIMER !',
                        style: TextStyle(
                            color: kColor2, fontWeight: FontWeight.bold),
                      ),
                    ),
                    content: Text(
                      'Welcome to MatchMate - a platform designed exclusively for adults. Before proceeding, please take a moment to read and acknowledge the following,\nThis app is intended for use by individuals who are 18 years of age or older. By accessing and using MatchMate, you confirm that you are above the age of 18 and legally eligible to participate in activities within this platform.\nMatchMate promotes responsible and respectful interactions. Users are expected to adhere to our community guidelines, ensuring a safe and enjoyable environment for everyone.\n\nAre you above 18 years old?',
                      style: TextStyle(
                        color: Color.fromRGBO(36, 20, 104, 0.6),
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    )),
              );
            },
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height * 0.03,
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
