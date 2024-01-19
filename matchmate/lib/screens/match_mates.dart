import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:matchmate/screens/profile.dart';
import '../components/mate_card.dart';
import '../components/constants.dart';
import '../components/search_bar.dart';
import '../components/appbar1.dart';

late User? loggedInUser;

class MatchMates extends StatefulWidget {
  static String id = 'home';
  const MatchMates({Key? key}) : super(key: key);

  @override
  State<MatchMates> createState() => _MatchMatesState();
}

class _MatchMatesState extends State<MatchMates> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? loggedInUserGender;
  late TextEditingController searchController;

  @override
  void initState() {
    getCurrentUser();
    getUserData();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
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
      loggedInUserGender = userSnapshot['gender'];
    });
  }

  void addToFavorites(String userEmail) async {
    DocumentReference userProfile =
        _fireStore.collection('profiles').doc(loggedInUser?.email);

    await userProfile.update({
      'favourites': FieldValue.arrayUnion([userEmail]),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(),
      body: Column(
        children: [
          SizedBox(height: 20),
          Searchbar(
            searchController: searchController,
            onSearchChanged: (query) {
              setState(() {
                searchController.text = query;
              });
            },
          ),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Your Matchmates",
              style: textStyle,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: StreamBuilder(
              stream: _fireStore.collection('profiles').snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                var profiles = snapshot.data!.docs;

                var filteredProfiles = profiles.where((profile) {
                  var gender = profile['gender'] ?? '';
                  var matchesGender =
                      (loggedInUserGender == 'male' && gender == 'female') ||
                          (loggedInUserGender == 'female' && gender == 'male');

                  var matchesSearchQuery = searchController.text.isEmpty ||
                      (profile['firstname'] as String)
                          .toLowerCase()
                          .contains(searchController.text.toLowerCase());

                  return matchesGender && matchesSearchQuery;
                }).toList();

                return Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: filteredProfiles.length == 0
                      ? Center(
                          child: Text(
                            'No any search result found',
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 30.0,
                            mainAxisSpacing: 30.0,
                          ),
                          itemCount: filteredProfiles.length,
                          itemBuilder: (context, index) {
                            var profile = filteredProfiles[index].data()
                                as Map<String, dynamic>;
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Profile(
                                            userEmail: profile['email'])));
                              },
                              child: MateCard(
                                name: profile['firstname'],
                                image: profile['image'],
                              ),
                            );
                          },
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
