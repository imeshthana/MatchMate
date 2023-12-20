import 'package:flutter/material.dart';
import 'login.dart';

class CreateAccount extends StatelessWidget {
  const CreateAccount({super.key});

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
                  hintText: 'Enter Your Email',
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Expanded(
                child: TextField(
                  
                  textAlign: TextAlign.center,
                    style: TextStyle(
                    fontSize: 16.0, // Set the font size as desired
                    fontWeight: FontWeight.bold, // Set the font weight as desired
                    fontStyle: FontStyle.italic, // Set the font style as desired
                    color: Colors.black, // Set the text color as desired
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(
                          width: 2.0), // Set the border width as desired
                    ),
                    labelText: null,
                    hintText: 'Enter Your Password',
                  ),
                ),
              ),
            ),

            SizedBox(height: 40,),

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
        MaterialPageRoute(builder: (context)=>Login()
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
        Size(150.0, 40.0),),
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
        'Next',
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
