import 'package:flutter/material.dart';
import 'userdetails1.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xff241468), Color(0xFFC70039)],
              tileMode: TileMode.clamp,
            ).createShader(bounds);
          },
          child: const Text(
            'MatchMate',
            style: TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
      
        padding: const EdgeInsets.all(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.25,
              alignment: Alignment.bottomCenter,
              child: Image.asset(
                "assets/1.jpg",
                height: 250,
              ),
            ),
            SizedBox(
              height: 50,
            ),
            Container(
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          width: 2.0),
                  ),
                  labelText: null,
                  hintText: 'Enter Your Username',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: TextField(
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          width: 2.0), 
                  ),
                  labelText: null,
                  hintText: 'Enter Your Password',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
           

        

        Container(
       decoration: BoxDecoration(
        gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [Color(0xff241468), Color(0xFFC70039)],
    ),
    borderRadius: BorderRadius.circular(20.0),
  ),
  child: TextButton(
    onPressed: () {
      Navigator.of(context)
      .push(
        MaterialPageRoute(builder: (context)=>Userdetails1()
        )
      );
    },
    style: ButtonStyle(
      
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
        minimumSize: MaterialStateProperty.all<Size>(
        Size(150.0, 40.0),
        ),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.resolveWith<Color?>(
        (Set<MaterialState> states) {
          if (states.contains(MaterialState.hovered))
            return Colors.white.withOpacity(0.04);
          if (states.contains(MaterialState.focused) ||
              states.contains(MaterialState.pressed))
            return Colors.white10.withOpacity(0.12);
          return null;
        },
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        'LOGIN',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic,
        ),
      ),
    ),
  ),
),

          ],
        ),
      ),
    

    );
  }
}