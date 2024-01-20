import 'package:flutter/material.dart';
import 'package:matchmate/components/appbar1.dart';
import 'package:matchmate/screens/profile.dart';
import '../components/constants.dart';
import '../components/search_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

late User? loggedInUser;

class Requests extends StatefulWidget {
  const Requests({super.key});

  @override
  State<Requests> createState() => _RequestsState();
}

class _RequestsState extends State<Requests> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  List<String> requests = [];

  void initState() {
    getCurrentUser();
    fetchRequests();
    super.initState();
  }

  void getCurrentUser() async {
    final user = await _auth.currentUser;
    if (user != null) {
      loggedInUser = user;
    }
  }

  void fetchRequests() async {
    if (loggedInUser != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('profiles')
          .doc(loggedInUser?.email)
          .get();

      List<dynamic>? userRequets = userSnapshot['requests'];

      if (userRequets != null) {
        setState(() {
          requests = List<String>.from(userRequets);
        });
      }
    }
  }

  void removeFromRequests(String userEmail) async {
    setState(() {
      requests.remove(userEmail);
    });

    DocumentReference userProfile =
        _fireStore.collection('profiles').doc(loggedInUser?.email);

    DocumentReference favouriteUserProfile =
        _fireStore.collection('profiles').doc(userEmail);

    await userProfile.update({
      'requests': FieldValue.arrayRemove([userEmail]),
    });

    await favouriteUserProfile.update({
      'pendings': FieldValue.arrayRemove([loggedInUser?.email]),
    });
  }

  Future<Map<String, dynamic>> fetchRequestsInfo(String favouritesMail) async {
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('profiles')
        .doc(favouritesMail)
        .get();

    return {
      'name': userSnapshot['firstname'],
      'image': userSnapshot['image'],
    };
  }

  void addToFavourites(String userEmail) async {
    setState(() {
      requests.remove(userEmail);
    });

    DocumentReference userProfile =
        _fireStore.collection('profiles').doc(loggedInUser?.email);

    DocumentReference favouritesProfile =
        _fireStore.collection('profiles').doc(userEmail);

    await userProfile.update({
      'favourites': FieldValue.arrayUnion([userEmail]),
    });

    await favouritesProfile.update({
      'favourites': FieldValue.arrayUnion([loggedInUser?.email]),
    });

    await userProfile.update({
      'requests': FieldValue.arrayRemove([userEmail]),
    });

    await favouritesProfile.update({
      'pendings': FieldValue.arrayRemove([loggedInUser?.email]),
    });
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
                child: requests.length == 0
                    ? Padding(
                        padding: const EdgeInsets.only(top: 28.0),
                        child: Center(
                          child: Text(
                            'No Requests',
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
                        itemCount: requests.length,
                        itemBuilder: (context, index) {
                          return FutureBuilder<Map<String, dynamic>>(
                            future: fetchRequestsInfo(requests[index]),
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
                                                            requests[index]);
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
                                                  TextButton(
                                                      onPressed: () {
                                                        addToFavourites(
                                                            requests[index]);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            15)),
                                                            title: Center(
                                                              child: Text(
                                                                  '$name is added to your favourites',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style:
                                                                      textStyle),
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(5.0),
                                                          child: ShaderMask(
                                                            shaderCallback:
                                                                (Rect bounds) {
                                                              return gradient
                                                                  .createShader(
                                                                      bounds);
                                                            },
                                                            child: const Text(
                                                              'Accept',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      15.0,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  color:
                                                                      kColor2),
                                                            ),
                                                          ),
                                                        ),
                                                      )),
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
                                                                removeFromRequests(
                                                                    requests[
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
                                                                          'You deleted the request from $name',
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
                                                              'Delete Request',
                                                              style: TextStyle(
                                                                  color:
                                                                      kColor2),
                                                            ),
                                                          ),
                                                          content: Text(
                                                              'Do you really want to delete the request from $name?',
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
