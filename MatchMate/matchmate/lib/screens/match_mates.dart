import 'package:flutter/material.dart';
import 'package:matchmate/components/mate_card.dart';
import '../components/constants.dart';
import '../components/search_bar.dart';
import '../components/app_bar.dart';

class MatchMates extends StatefulWidget {
  const MatchMates({super.key});

  @override
  State<MatchMates> createState() => _MatchMatesState();
}

class _MatchMatesState extends State<MatchMates> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: Appbar(),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Searchbar(),
          Container(
            alignment: Alignment.topLeft,
            padding: EdgeInsets.only(left: 20, top: 20),
            child: Text(
              "Your Matchmates",
              style: TextStyle(
                color: Color.fromRGBO(36, 20, 104, 0.6),
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MateCard(
                          name: 'Anaya',
                          image: 'assets/1.jpg',
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        MateCard(
                          name: 'Steffani',
                          image: 'assets/2.jpg',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MateCard(
                          name: 'Alyne',
                          image: 'assets/3.jpg',
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        MateCard(
                          name: 'Angela',
                          image: 'assets/5.jpg',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MateCard(
                          name: 'Fadrona',
                          image: 'assets/6.jpg',
                        ),
                        SizedBox(
                          width: 40,
                        ),
                        MateCard(
                          name: 'Lucy',
                          image: 'assets/7.jpg',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

