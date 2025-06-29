// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:synceat/presentation/screens/auth/login_screen.dart';
import 'package:synceat/presentation/screens/auth/signin_screen.dart';
import 'package:synceat/core/constants/image_constant.dart';
import 'package:synceat/core/constants/color_constants.dart';

// Get Started Page
class GetStartedPage extends StatelessWidget {
  const GetStartedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              ColorConstants.primaryColor,
              ColorConstants.secondaryColor,
              ColorConstants.backgroundColor,
            ],
            stops: [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Logo
                      Container(
                        width: 230, // Match the image size
                        height: 230, // Match the image size
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Image(
                          height: 230,
                          width: 230,
                          image: AssetImage(ImageConstant.logo),
                          fit: BoxFit.contain,
                        ),
                      ),
                      const SizedBox(height: 30),

                      // App Name
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Sync',
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Lufga',
                              color: ColorConstants.textPrimary,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: ColorConstants.shadowColor,
                                ),
                              ],
                            ),
                          ),
                          const Text(
                            'Eat',
                            style: TextStyle(
                              fontSize: 36,
                              fontFamily: 'Lufga',
                              fontWeight: FontWeight.bold,
                              color: ColorConstants.logoColor,
                              letterSpacing: 2,
                              shadows: [
                                Shadow(
                                  offset: Offset(0, 2),
                                  blurRadius: 4,
                                  color: ColorConstants.shadowColor,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // Tagline
                      Text(
                        'Sync your meals, sync your life',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 18,
                          color: ColorConstants.textPrimary,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Lufga',
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Description
                      Text(
                        'Plan, track, and enjoy your meals\nwith friends and family',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Lufga',
                          color: ColorConstants.textSecondary,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),

                // Buttons
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Get Started Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpPage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorConstants.whiteColor,
                            foregroundColor: ColorConstants.secondaryColor,
                            elevation: 8,
                            shadowColor: ColorConstants.shadowColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(36),
                            ),
                          ),
                          child: const Text(
                            'Get Started',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Already have account
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ),
                          );
                        },
                        child: Text(
                          'Already have an account? Sign In',
                          style: TextStyle(
                            color: ColorConstants.textSecondary.withOpacity(
                              0.9,
                            ),
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
