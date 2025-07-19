import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:synceat/presentation/controller/bloc/auth_service_bloc.dart';
import 'package:synceat/presentation/controller/login_screen_controller.dart';
import 'package:synceat/presentation/controller/signup_screen_controller.dart';
import 'package:synceat/presentation/screens/splashscreen/splashscreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:synceat/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
        BlocProvider(create: (context) => AuthServiceBloc()),
      ],
      child: MaterialApp(
        home: const SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
