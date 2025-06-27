import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:synceat/presentation/screens/auth/getstarted_screen.dart';
import 'package:synceat/presentation/screens/auth/login_screen.dart';
import 'package:synceat/presentation/screens/home/home_screen.dart';

class IsuserloginedScreen extends StatefulWidget {
  const IsuserloginedScreen({super.key});

  @override
  State<IsuserloginedScreen> createState() => _IsuserloginedScreenState();
}

class _IsuserloginedScreenState extends State<IsuserloginedScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomeScreen();
          } else {
            return GetStartedPage();
          }
        },
      ),
    );
  }
}
