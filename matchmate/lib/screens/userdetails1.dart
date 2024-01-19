import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:matchmate/components/image.dart';
import 'package:matchmate/components/main_button.dart';
import 'package:matchmate/components/edit_button.dart';
import 'package:matchmate/components/textfield.dart';
import '../components/reusable_card.dart';
import '../components/appbar2.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/screens/userdetails2.dart';

enum Gender {
  male,
  female,
}

late User? loggedInUser;

final _fireStore = FirebaseFirestore.instance;

class Userdetails1 extends StatefulWidget {
  static String id = 'userdetails1';
  Userdetails1({required this.userEmail});
  final String userEmail;

  @override
  _Userdetails1State createState() => _Userdetails1State();
}

class _Userdetails1State extends State<Userdetails1> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController occupationController = TextEditingController();

  List<bool> isSelected = [false, false, false];
  final _auth = FirebaseAuth.instance;
  Gender? selectedGender;
  int age = 25;

  @override
  void initState() {
    getCurrentUser();
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Appbar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const MainImage(),
              const SizedBox(
                height: 30,
              ),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ReusableTextField(
                        null, false, firstNameController, "First Name", null),
                    const SizedBox(height: 20),
                    ReusableTextField(
                        null, false, lastNameController, "Last Name", null),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Container(
                child: Row(
                  children: [
                    Text(
                      'You are a',
                      style: textStyle,
                    ),
                    // SizedBox(
                    //   width: 10,
                    // ),
                    Spacer(),
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.male;
                          });
                        },
                        decoration: selectedGender == Gender.male
                            ? BoxDecoration(
                                gradient: gradient,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Colors.transparent, width: 2.0))
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: GradientBoxBorder(
                                    gradient: gradient, width: 2.0),
                              ),
                        cardChild: Text(
                          'Male',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: selectedGender == Gender.male
                                ? Colors.white
                                : Color.fromRGBO(36, 20, 104, 0.5),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: ReusableCard(
                        onPress: () {
                          setState(() {
                            selectedGender = Gender.female;
                          });
                        },
                        decoration: selectedGender == Gender.female
                            ? BoxDecoration(
                                gradient: gradient,
                                borderRadius: BorderRadius.circular(10.0),
                                border: Border.all(
                                    color: Colors.transparent, width: 2.0))
                            : BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
                                border: GradientBoxBorder(
                                    gradient: gradient, width: 2.0),
                              ),
                        cardChild: Text(
                          'Female',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: selectedGender == Gender.female
                                ? Colors.white
                                : Color.fromRGBO(36, 20, 104, 0.5),
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Your Age',
                    style: textStyle,
                  ),
                  Spacer(),
                  Container(
                    child: Container(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            setState(() {
                              age--;
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.minus,
                            color: Colors.black,
                          ),
                        ),
                        Container(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              age.toString(),
                              style: TextStyle(
                                fontSize: 17.5,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          decoration: BoxDecoration(
                            gradient: gradient,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              age++;
                            });
                          },
                          child: Icon(
                            FontAwesomeIcons.plus,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ReusableTextField(null, false, occupationController,
                  "You are a 'Developer' etc.", null),
              const SizedBox(height: 20),
              MainButton(
                text: 'NEXT',
                onPress: () async {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Userdetails2(
                          userEmail: widget.userEmail,
                          firstName: firstNameController.text,
                          lastName: lastNameController.text,
                          age: age,
                          gender:
                              selectedGender == Gender.male ? 'male' : 'female',
                          occupation: occupationController.text,
                        ),
                      ));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
