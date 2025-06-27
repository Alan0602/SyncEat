import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:synceat/presentation/screens/auth/getstarted_screen.dart';
import 'package:synceat/presentation/screens/bottom_navigation/bottom_navigation.dart';

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
            return BottomNavigation();
          } else {
            return GetStartedPage();
          }
        },
      ),
    );
  }
}
