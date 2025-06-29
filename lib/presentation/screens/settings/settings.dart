import 'package:flutter/material.dart';
import 'package:synceat/core/constants/color_constants.dart';
import 'package:synceat/presentation/screens/Meal_history/meal_history_screen.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Center(
          child: Text(
            'Settings Page',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: ColorConstants.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const ListTile(
          leading: Icon(
            Icons.account_circle,
            color: ColorConstants.primaryColor,
          ),
          title: Text('Profile'),
        ),
        ListTile(
          leading: const Icon(
            Icons.history_toggle_off,
            color: ColorConstants.primaryColor,
          ),
          title: const Text('Meal History'),
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MealHistoryPage(),
                ),
              ),
        ),
        const ListTile(
          leading: Icon(
            Icons.notifications,
            color: ColorConstants.primaryColor,
          ),
          title: Text('Notifications'),
        ),
        const ListTile(
          leading: Icon(Icons.security, color: ColorConstants.primaryColor),
          title: Text('Privacy & Security'),
        ),
        const ListTile(
          leading: Icon(Icons.language, color: ColorConstants.primaryColor),
          title: Text('Language'),
        ),
        const ListTile(
          leading: Icon(Icons.help, color: ColorConstants.primaryColor),
          title: Text('Help & Support'),
        ),
        const ListTile(
          leading: Icon(Icons.info, color: ColorConstants.primaryColor),
          title: Text('About'),
        ),
      ],
    );
  }
}
