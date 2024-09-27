import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dashboard/screen/home_screen.dart';

import 'package:dashboard/screen/siginup_screen.dart';
import 'package:dashboard/utils/color_utils.dart';

import '../reusable_Widgits/reusable_Widgits.dart';

class SiginupScreen extends StatefulWidget {
  const SiginupScreen({super.key});

  @override
  State<SiginupScreen> createState() => _SiginupScreenState();
}

class _SiginupScreenState extends State<SiginupScreen> {
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              hexStringToColor("CB2B93"),
              hexStringToColor("9546C4"),
              hexStringToColor("5E61F4"),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.05, // Responsive padding
                    screenHeight * 0.2,
                    screenWidth * 0.05,
                    20,
                  ),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height:
                            screenHeight * 0.2, // Responsive height for logo
                        child: logoWidget("assets/images/b.png"),
                      ),
                      SizedBox(
                        height: screenHeight * 0.05, // Responsive padding
                      ),
                      reusableTextField("Enter Email ID", Icons.person_outline,
                          false, _emailTextController),
                      SizedBox(
                        height: screenHeight * 0.05, // Responsive padding
                      ),
                      reusableTextField("Enter Password", Icons.lock_outline,
                          true, _passwordTextController),
                      SizedBox(
                        height: screenHeight * 0.05, // Responsive padding
                      ),
                      signInSignUpButton(context, true, () {
                        FirebaseAuth.instance
                            .signInWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text)
                            .then((value) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        }).onError((error, stackTrace) {
                          print("Error ${error.toString()}");
                        }); // Add your sign-up logic here
                      }),
                      SizedBox(
                        height: screenHeight * 0.05, // Responsive padding
                      ),
                      signUpOption(), // Include sign-up option
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Text(
          "Don't have an account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const SignUpScreen(),
              ),
            );
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(
              color: Color(0xFF1BCE7A),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
