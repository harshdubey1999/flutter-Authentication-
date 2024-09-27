import 'package:dashboard/screen/sigin_screen.dart';
import 'package:flutter/material.dart';

// Define the list of URLs as a global variable
import 'package:firebase_core/firebase_core.dart';
// Add this

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //  Initialize for mobile platforms
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'URL Launcher Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SiginupScreen(),
    );
  }
}
