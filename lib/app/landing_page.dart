import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/signin_page.dart';

class LandingPage extends StatelessWidget {
  final AuthBase auth;
  const LandingPage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    //*CON STRERAMBUILDER ASCOLTO LO STREAM
    return StreamBuilder<User?>(
      stream: auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user != null
              ? HomePage(
                  auth: auth,
                )
              : SignInPage(
                  auth: auth,
                );
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
