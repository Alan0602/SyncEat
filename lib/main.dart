import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:synceat/presentation/controller/login_screen_controller.dart';
import 'package:synceat/presentation/controller/signup_screen_controller.dart';
import 'package:synceat/presentation/widgets/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:synceat/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SignupScreenController()),
        ChangeNotifierProvider(create: (context) => LoginScreenController()),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
