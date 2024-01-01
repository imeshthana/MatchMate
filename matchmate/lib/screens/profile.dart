import 'package:flutter/material.dart';
import 'package:matchmate/components/app_bar.dart';
import '../components/constants.dart';
import '../components/message_button.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: MessageButton(),
      // floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
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
                        image: AssetImage("assets/8.jpg"),
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
                  Positioned(
                    top: 20.0,
                    right: 20.0,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [Color(0xff241468), Color(0xFFC70039)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ).createShader(bounds);
                      },
                      child: Text(
                        'Arjun Aryan',
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
                                style: TextStyle(
                                  color: Color.fromRGBO(36, 20, 104, 0.6),
                                  fontSize: 17.5,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                              child: Text(
                                "Developer",
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
                    ],
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        child: Text(
                          "25",
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
                      Text(
                        "yrs",
                        style: TextStyle(
                          color: Color.fromRGBO(36, 20, 104, 0.6),
                          fontSize: 17.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 0,
                  ),
                  Row(
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          color: Color.fromRGBO(36, 20, 104, 0.6),
                          fontSize: 17.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Container(
                        child: Text(
                          "Maharastra, India",
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
                      Text(
                        "Bio",
                        style: TextStyle(
                          color: Color.fromRGBO(36, 20, 104, 0.6),
                          fontSize: 17.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ",
                            // textAlign: TextAlign.justify,
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
                      Text(
                        "Preferences",
                        style: TextStyle(
                          color: Color.fromRGBO(36, 20, 104, 0.6),
                          fontSize: 17.5,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
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
                      children: [
                        Container(
                          child: Text(
                            'Sports',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17.5),
                          ),
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(199, 0, 57, 0.8),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                          child: Text(
                            'Education',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17.5),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(199, 0, 57, 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                          child: Text(
                            'Travelling',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17.5),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(199, 0, 57, 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                          child: Text(
                            'Dancing',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17.5),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(199, 0, 57, 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                          child: Text(
                            'Western Music',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17.5),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(199, 0, 57, 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                          child: Text(
                            'Meet People',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17.5),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(199, 0, 57, 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                        ),
                        Container(
                          child: Text(
                            'Cooking',
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                                fontSize: 17.5),
                          ),
                          decoration: BoxDecoration(
                              color: Color.fromRGBO(199, 0, 57, 0.8),
                              borderRadius: BorderRadius.circular(10)),
                          padding: EdgeInsets.all(5),
                        ),
                      ],
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

