import 'package:flutter/material.dart';
import 'package:matchmate/components/appbar1.dart';
import 'package:matchmate/screens/chat_screen.dart';
import 'package:matchmate/screens/edit_screen.dart';
import '../components/constants.dart';
import '../components/edit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchmate/components/preference.dart';

late User? loggedInUser;

class UserProfile extends StatefulWidget {
  static String id = 'user_profile';
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? firstName;
  String? lastName;
  String? state;
  String? country;
  int? age;
  String? bio;
  String? occupation;
  List<String> preferences = [];
  String? profileImageUrl;

  @override
  void initState() {
    getCurrentUser();
    getUserData();
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  Future<void> getUserData() async {
    loggedInUser = _auth.currentUser!;
    DocumentSnapshot userSnapshot =
        await _fireStore.collection('profiles').doc(loggedInUser?.email).get();

    setState(() {
      firstName = userSnapshot['firstname'].toString();
      lastName = userSnapshot['lastname'].toString();
      age = userSnapshot['age'];
      bio = userSnapshot['bio'];
      occupation = userSnapshot['occupation'];
      state = userSnapshot['state'];
      country = userSnapshot['country'];
      preferences = List<String>.from(userSnapshot['preferences'] ?? []);
      profileImageUrl = userSnapshot['image'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: EditButton(
        cardChild: Icon(Icons.edit_sharp),
        onPress: () {
          Navigator.pop(context);
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const EditProfile()));
        },
      ),
      appBar: Appbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 350,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35)),
                child: Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(profileImageUrl ?? ''),
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  Container(
                    height: 350,
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
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return gradient.createShader(bounds);
                      },
                      child: Text(
                        '$firstName $lastName',
                        style: TextStyle(
                          fontSize: 35.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                    ),
                  ),
                ]),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.only(right: 20, left: 20),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Container(
                              child: Text(
                                "Title",
                                style: textStyle,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              child: Text(
                                '$occupation',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Text(
                              "$age",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 17.5,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text("yrs", style: textStyle),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("From", style: textStyle),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Text(
                          "$state, $country",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17.5,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("Bio", style: textStyle),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            '$bio',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text("Preferences", style: textStyle),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(bottom: 20.0),
                    child: Wrap(
                      spacing: 15.0,
                      runSpacing: 10.0,
                      children: preferences
                          .map((preference) =>
                              Preference(preference: preference))
                          .toList(),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
