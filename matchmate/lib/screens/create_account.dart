import 'package:flutter/material.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/components/main_button.dart';
import 'package:matchmate/screens/userdetails1.dart';
import '../components/textfield.dart';
import '../components/appbar2.dart';
import '../components/image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatefulWidget {
  static String id = 'create_screen';
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  Widget build(BuildContext context) {
    TextEditingController passwordController = TextEditingController();
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    final _auth = FirebaseAuth.instance;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Appbar(),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Hero(tag: 'logo', child: MainImage()),
                const SizedBox(
                  height: 50,
                ),
                ReusableTextField('Enter Your Username', false,
                    usernameController, "Enter Your Username", null),
                const SizedBox(
                  height: 30,
                ),
                ReusableTextField('Enter Your Email', false, emailController,
                    "Enter Your Email", null),
                const SizedBox(
                  height: 30,
                ),
                ReusableTextField('Enter Your Password', true,
                    passwordController, "Enter Your Password", null),
                const SizedBox(
                  height: 40,
                ),
                MainButton(
                  text: "Next",
                  onPress: () async {
                    try {
                      await _auth.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                      );
                      _auth
                          .signInWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text)
                          .then((signedUser) => {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Userdetails1(
                                        userEmail: emailController.text,
                                      ),
                                    ))
                              });
                    } on Exception catch (e) {
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
                          content: Text(
                              'Email address must end with @gmail.com\nPassword must have at least 6 characters',
                              style: textStyle),
                        ),
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 30,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
