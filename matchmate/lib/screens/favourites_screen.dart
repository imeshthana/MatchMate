import 'package:flutter/material.dart';
import 'package:matchmate/components/appbar1.dart';
import '../components/constants.dart';
import '../components/search_bar.dart';

class FavouritesScreen extends StatefulWidget {
  const FavouritesScreen({super.key});

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  List<String> favorites = [
    'Anaya Pandey',
    'Fedrona Lucy',
    'Steffany Kirshy',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Appbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Searchbar(),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 20, top: 20),
              child: Text(
                "Your Favourites",
                style: textStyle,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: favorites.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin:
                        EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 0),
                    child: ListTile(
                      leading: Card(
                        margin: EdgeInsets.only(left: 0),
                        elevation: 5,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5.0),
                          child: Image.asset(
                            'assets/1.jpg',
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
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    padding: EdgeInsets.only(
                                        left: 10, top: 20, bottom: 20),
                                    child: Text(
                                      favorites[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
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
                                        // setState(() {
                                        //   favorites.removeAt(index);
                                        // });
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.message,
                                        color: Colors.white,
                                        size: 27,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 3,
                            right: 3,
                            child: Container(
                              // Add your notification icon here
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.transparent, // Background color
                                border: Border.all(
                                  color: Colors.transparent, // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              padding: EdgeInsets.all(1),
                              child: Icon(
                                Icons.notifications,
                                color: Colors.white,
                                size: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
