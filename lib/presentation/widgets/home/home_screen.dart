import 'package:flutter/material.dart';
import 'package:synceat/presentation/controller/login_screen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              'Welcome to Home Screen',
              style: TextStyle(fontSize: 24, color: Colors.black),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () async {
              // Add your logout logic here
              await LoginScreenController().signOut(context);
            },
            child: Text('Logout'),
          ),
        ],
      ),
    );
  }
}
