// import 'package:flutter/material.dart';
// import 'package:matchmate/components/mate_card.dart';
// import '../components/constants.dart';
// import '../components/search_bar.dart';
// import '../components/appbar1.dart';

// class MatchMates extends StatefulWidget {
//   const MatchMates({super.key});

//   @override
//   State<MatchMates> createState() => _MatchMatesState();
// }

// class _MatchMatesState extends State<MatchMates> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: Appbar(),
//       body: Column(
//         children: [
//           SizedBox(
//             height: 20,
//           ),
//           Searchbar(),
//           Container(
//             alignment: Alignment.topLeft,
//             padding: EdgeInsets.only(left: 20, top: 20),
//             child: Text(
//               "Your Matchmates",
//               style: textStyle,
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: Container(
//               padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         MateCard(
//                           name: 'Anaya',
//                           image: 'assets/1.jpg',
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         MateCard(
//                           name: 'Steffani',
//                           image: 'assets/2.jpg',
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         MateCard(
//                           name: 'Alyne',
//                           image: 'assets/3.jpg',
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         MateCard(
//                           name: 'Angela',
//                           image: 'assets/5.jpg',
//                         ),
//                       ],
//                     ),
//                   ),
//                   Expanded(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         MateCard(
//                           name: 'Fadrona',
//                           image: 'assets/6.jpg',
//                         ),
//                         SizedBox(
//                           width: 40,
//                         ),
//                         MateCard(
//                           name: 'Lucy',
//                           image: 'assets/7.jpg',
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/mate_card.dart';
import '../components/constants.dart';
import '../components/search_bar.dart';
import '../components/appbar1.dart';

late User? loggedInUser;

class MatchMates extends StatefulWidget {
  const MatchMates({Key? key}) : super(key: key);

  @override
  State<MatchMates> createState() => _MatchMatesState();
}

class _MatchMatesState extends State<MatchMates> {
  final _fireStore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  String? loggedInUserGender;

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
    loggedInUser = FirebaseAuth.instance.currentUser!;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('profiles')
        .doc(loggedInUser?.email)
        .get();

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
          Searchbar(),
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
                  return (loggedInUserGender == 'male' && gender == 'female') ||
                      (loggedInUserGender == 'female' && gender == 'male');
                }).toList();

                return Container(
                  padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 30.0,
                      mainAxisSpacing: 30.0,
                    ),
                    itemCount: filteredProfiles.length,
                    itemBuilder: (context, index) {
                      var profile = filteredProfiles[index].data()
                          as Map<String, dynamic>;
                      return MateCard(
                        name: profile['firstname'],
                        image: 'assets/1.jpg',
                        onFavouritePressed: () {
                          addToFavorites(profile['email']);
                        },
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
