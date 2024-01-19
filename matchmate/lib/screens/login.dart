import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/components/main_button.dart';
import 'package:matchmate/components/textfield.dart';
import 'package:matchmate/screens/landing_page.dart';
import '../components/appbar1.dart';
import '../components/image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Login extends StatelessWidget {
  static String id = 'login';
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final _auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(50.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Hero(
                tag: 'logo',
                child: Image.asset(
                  "assets/logo.jpg",
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              ReusableTextField('Enter Your Email Address', false,
                  emailController, "Enter Your Email Address", null),
              const SizedBox(
                height: 30,
              ),
              ReusableTextField('Enter Your Password', true, passwordController,
                  "Enter Your Password", null),
              const SizedBox(
                height: 40,
              ),
              MainButton(
                  text: "LOGIN",
                  onPress: () {
                    _auth
                        .signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text)
                        .then((signedUser) => {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MatchMates())),
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  title: Center(
                                    child: Text(
                                        'Successfully logged in as ${emailController.text}',
                                        textAlign: TextAlign.center,
                                        style: textStyle),
                                  ),
                                ),
                              )
                            })
                        .catchError((e) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                'Close',
                                style: TextStyle(color: kColor1, fontSize: 20),
                              ),
                            ),
                          ],
                          title: Center(
                            child: Text(
                              'Login Error',
                              style: TextStyle(color: kColor2),
                            ),
                          ),
                          content: Text('Invalid email or incorrect password.',
                              style: textStyle),
                        ),
                      );
                    });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
