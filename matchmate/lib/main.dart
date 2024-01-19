import 'package:flutter/material.dart';
import 'package:matchmate/screens/landing_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:matchmate/screens/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyA3hSDIWTZb_HwSurQaEz6x816A1r2ErpQ',
          appId: '1:801264951582:android:54edff208c4be40c51a90f',
          messagingSenderId: '801264951582',
          projectId: 'matchmate-cpbio8292'));
  runApp(const MyApp());
}

class MatchMate extends StatelessWidget {
  const MatchMate({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MatchMate',
      home: LandingPage(),
    );
  }
}
