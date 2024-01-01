import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matchmate/components/image.dart';
import 'package:matchmate/components/main_button.dart';
import 'package:matchmate/components/message_button.dart';
import 'package:matchmate/components/textfield.dart';
import '../components/reusable_card.dart';
import '../components/appbar.dart';
import 'package:matchmate/components/constants.dart';
import 'package:matchmate/screens/userdetails2.dart';

enum Gender {
  male,
  female,
}

late User? loggedInUser;

final _fireStore = FirebaseFirestore.instance;

class Userdetails1 extends StatefulWidget {
  Userdetails1({required this.userName});
  final String userName;

  @override
  _Userdetails1State createState() => _Userdetails1State();
}

class _Userdetails1State extends State<Userdetails1> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  List<bool> isSelected = [false, false, false];
  final _auth = FirebaseAuth.instance;
  Gender? selectedGender;
  int age = 25;

  @override
  void initState() {
    super.initState();
    getCurrentUser();
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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const MainImage(),
            const SizedBox(
              height: 50,
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ReusableTextField(
                      null, false, firstNameController, "First Name"),
                  const SizedBox(height: 20),
                  ReusableTextField(
                      null, false, lastNameController, "Last Name"),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
                child: Row(
              children: [
                Expanded(
                  child: ReusableCard(
                    onPress: () {
                      setState(() {
                        selectedGender = Gender.male;
                      });
                    },
                    decoration: selectedGender == Gender.male
                        ? BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.2, 1],
                              colors: [
                                Color.fromARGB(255, 21, 11, 64),
                                Color(0xFFC70039)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                        : BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black, width: 1)),
                    cardChild: Text(
                      'Male',
                      style: TextStyle(
                        fontSize: 20,
                        color: selectedGender == Gender.male
                            ? Colors.white
                            : Colors.black,
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
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.2, 1],
                              colors: [
                                Color.fromARGB(255, 21, 11, 64),
                                Color(0xFFC70039)
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.0),
                          )
                        : BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(color: Colors.black, width: 1)),
                    cardChild: Text(
                      'Female',
                      style: TextStyle(
                        fontSize: 20,
                        color: selectedGender == Gender.female
                            ? Colors.white
                            : Colors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            )),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'AGE',
                  style: TextStyle(
                    color: Color.fromRGBO(36, 20, 104, 0.6),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
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
                      SizedBox(
                        width: 5,
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            age.toString(),
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w900,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            stops: [0.2, 1],
                            colors: [
                              Color.fromARGB(255, 21, 11, 64),
                              Color(0xFFC70039)
                            ],
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      SizedBox(
                        width: 5,
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
            MainButton(
              text: 'NEXT',
              onPress: () async {
                // await _fireStore
                //     .collection('profiles')
                //     .doc(widget.userName)
                //     .set({
                //   'firstname': firstNameController.text,
                //   'lastname': lastNameController.text,
                //   'age': age,
                //   'gender': selectedGender == Gender.male ? 'male' : 'female',
                // });

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Userdetails2(
                        userName: widget.userName,
                        firstName: firstNameController.text,
                        lastName: lastNameController.text,
                        age: age,
                        gender: selectedGender == Gender.male ? 'male' : 'female',
                      ),
                    ));
              },
            )
          ],
        ),
      ),
    );
  }
}
