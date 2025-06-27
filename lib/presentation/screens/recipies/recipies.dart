import 'package:flutter/material.dart';
import 'package:synceat/core/constants/color_constants.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Recipes Page',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: ColorConstants.primaryColor,
        ),
      ),
    );
  }
}