import 'package:flutter/material.dart';
import 'package:matchmate/components/main_button.dart';
import 'package:matchmate/screens/userdetails1.dart';
import '../components/textfield.dart';
import '../components/appbar.dart';
import '../components/image.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CreateAccount extends StatefulWidget {
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

    return Scaffold(
      
      backgroundColor: Colors.white,
      appBar: const Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const MainImage(),
              const SizedBox(
                height: 50,
              ),
              ReusableTextField('Enter Your Username', false, usernameController,
                  "Enter Your Username"),
              const SizedBox(
                height: 30,
              ),
              ReusableTextField(
                  'Enter Your Email', false, emailController, "Enter Your Email"),
              const SizedBox(
                height: 30,
              ),
              ReusableTextField('Enter Your Password', true, passwordController,
                  "Enter Your Password"),
              const SizedBox(
                height: 30,
              ),
              MainButton(
                text: "Next",
                onPress: () async {
                  // await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  //   email: emailController.text,
                  //   password: passwordController.text,
                  // );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Userdetails1(
                          userName: usernameController.text,
                        ),
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
