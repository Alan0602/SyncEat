import 'package:flutter/material.dart';
import 'package:synceat/core/constants/color_constants.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Settings Page',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}