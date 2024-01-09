import 'package:flutter/material.dart';
import 'package:matchmate/components/main_button.dart';
import 'package:matchmate/components/textfield.dart';
import 'package:matchmate/screens/landing_page.dart';
import 'package:matchmate/screens/match_mates.dart';
import '../components/appbar1.dart';
import '../components/image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Appbar(),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const MainImage(),
            const SizedBox(
              height: 50,
            ),
            ReusableTextField('Enter Your Email Address', false, emailController,
                "Enter Your Email Address"),
            const SizedBox(
              height: 30,
            ),
            ReusableTextField('Enter Your Password', true, passwordController,
                "Enter Your Password"),
            const SizedBox(
              height: 30,
            ),
            MainButton(
                text: "LOGIN",
                onPress: () {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text)
                      .then((signedUser) => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MatchMates()))
                          });
                })
          ],
        ),
      ),
    );
  }
}
