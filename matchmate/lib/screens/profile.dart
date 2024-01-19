import 'package:flutter/material.dart';
import 'package:gradient_borders/gradient_borders.dart';
import 'package:matchmate/components/appbar1.dart';
import 'package:matchmate/screens/chat_screen.dart';
import '../components/constants.dart';
import '../components/edit_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchmate/components/preference.dart';

late User? loggedInUser;

class Profile extends StatefulWidget {
  static String id = 'profile';
  Profile({required this.userEmail});

  final String userEmail;

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
        await _fireStore.collection('profiles').doc(widget.userEmail).get();

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

  void addToPending(String userEmail) async {
    DocumentReference userProfile =
        _fireStore.collection('profiles').doc(loggedInUser?.email);

    DocumentReference favouritesProfile =
        _fireStore.collection('profiles').doc(userEmail);

    await userProfile.update({
      'pendings': FieldValue.arrayUnion([userEmail]),
    });

    await favouritesProfile.update({
      'requests': FieldValue.arrayUnion([loggedInUser?.email]),
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(
          child: Text('Request sent to $firstName',
              textAlign: TextAlign.center, style: textStyle),
        ),
      ),
    );
  }

  void removeFromPending(String userEmail) async {
    DocumentReference userProfile =
        _fireStore.collection('profiles').doc(loggedInUser?.email);

    DocumentReference favouritesProfile =
        _fireStore.collection('profiles').doc(userEmail);

    await userProfile.update({
      'pendings': FieldValue.arrayRemove([userEmail]),
    });

    await favouritesProfile.update({
      'requests': FieldValue.arrayRemove([loggedInUser?.email]),
    });

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        title: Center(
          child: Text('Request to $firstName is removed',
              textAlign: TextAlign.center, style: textStyle),
        ),
      ),
    );
  }

  bool isFavouritePressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.transparent,
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Container(
          padding: EdgeInsets.all(12.5),
          decoration: isFavouritePressed
              ? BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                  border: GradientBoxBorder(gradient: gradient, width: 2.0))
              : BoxDecoration(
                  gradient: gradient,
                  borderRadius: BorderRadius.circular(20.0),
                ),
          child: isFavouritePressed
              ? ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return gradient.createShader(bounds);
                  },
                  child: Icon(
                    Icons.favorite,
                    size: 25.0,
                  ),
                )
              : Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 25.0,
                ),
        ),
        onPressed: () async {
          setState(() {
            isFavouritePressed = !isFavouritePressed;
          });
          if (isFavouritePressed) {
            addToPending(widget.userEmail);
          } else {
            removeFromPending(widget.userEmail);
          }
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
