import 'package:flutter/material.dart';
import 'package:matchmate/components/appbar1.dart';
import 'package:matchmate/screens/profile.dart';
import '../components/constants.dart';
import '../components/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

late User? loggedInUser;

class Pending extends StatefulWidget {
  const Pending({super.key});

  @override
  State<Pending> createState() => _PendingState();
}

class _PendingState extends State<Pending> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List<String> pendings = [];

  void initState() {
    getCurrentUser();
    fetchPendings();
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  void fetchPendings() async {
    if (loggedInUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(loggedInUser?.email)
          .get();

      List<dynamic>? userPendings = userSnapshot['pendings'];

      if (userPendings != null) {
        setState(() {
          pendings = List<String>.from(userPendings);
        });
      }
    }
  }

  void removeFromPendings(String userEmail) async {
    setState(() {
      pendings.remove(userEmail);
    });

    DocumentReference userProfile =
        _fireStore.collection('profiles').doc(loggedInUser?.email);

    DocumentReference favouriteUserProfile =
        _fireStore.collection('profiles').doc(userEmail);

    await userProfile.update({
      'pendings': FieldValue.arrayRemove([userEmail]),
    });

    await favouriteUserProfile.update({
      'requests': FieldValue.arrayRemove([loggedInUser?.email]),
    });
  }

  Future<Map<String, dynamic>> fetchPendingsInfo(String favouritesMail) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('profiles')
        .doc(favouritesMail)
        .get();

    return {
      'name': userSnapshot['firstname'],
      'image': userSnapshot['image'],
    };
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Container(
                child: pendings.length == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Center(
                          child: Text(
                            'No Pending Requests',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: pendings.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<Map<String, dynamic>>(
                            future: fetchPendingsInfo(pendings[index]),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator(
                                  color: Color.fromRGBO(199, 0, 57, 0.8),
                                );
                              } else {
                                String name = snapshot.data!['name'];
                                String image = snapshot.data!['image'];

                                return Container(
                                  margin: EdgeInsets.only(
                                      top: 10, bottom: 10, left: 5, right: 0),
                                  child: ListTile(
                                    leading: Card(
                                      margin: EdgeInsets.only(left: 0),
                                      elevation: 5,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                        child: Image.network(
                                          image,
                                          fit: BoxFit.fill,
                                          height: 60,
                                          width: 45,
                                        ),
                                      ),
                                    ),
                                    title: Stack(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            gradient: gradient,
                                            borderRadius:
                                                BorderRadius.circular(20.0),
                                          ),
                                          child: Row(
                                            children: [
                                              Expanded(
                                                child: GestureDetector(
                                                  onTap: () {
                                                    Profile(
                                                        userEmail:
                                                            pendings[index]);
                                                  },
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        left: 15,
                                                        top: 20,
                                                        bottom: 20),
                                                    child: Text(
                                                      name,
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            AlertDialog(
                                                          shape: RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          15)),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () {
                                                                Navigator.pop(
                                                                    context);
                                                              },
                                                              child: Text(
                                                                'Cancel',
                                                                style: TextStyle(
                                                                    color:
                                                                        kColor1,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                            TextButton(
                                                              onPressed: () {
                                                                removeFromPendings(
                                                                    pendings[
                                                                        index]);
                                                                Navigator.pop(
                                                                    context);
                                                                showDialog(
                                                                  context:
                                                                      context,
                                                                  builder:
                                                                      (context) =>
                                                                          AlertDialog(
                                                                    shape: RoundedRectangleBorder(
                                                                        borderRadius:
                                                                            BorderRadius.circular(15)),
                                                                    title:
                                                                        Center(
                                                                      child: Text(
                                                                          'You deleted the request to $name',
                                                                          textAlign: TextAlign
                                                                              .center,
                                                                          style:
                                                                              textStyle),
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                              child: Text(
                                                                'Delete',
                                                                style: TextStyle(
                                                                    color:
                                                                        kColor1,
                                                                    fontSize:
                                                                        15),
                                                              ),
                                                            ),
                                                          ],
                                                          title: Center(
                                                            child: Text(
                                                              'Delete Pending Request',
                                                              style: TextStyle(
                                                                  color:
                                                                      kColor2),
                                                            ),
                                                          ),
                                                          content: Text(
                                                              'Do you really want to delete the request to $name?',
                                                              style: textStyle),
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }
                            },
                          );
                        }))
          ],
        ),
      ),
    );
  }
}
