import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/services/auth_provider.dart';
import 'package:time_tracker/app/sign_in/signin_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = AuthProvider.of(context); //LA CERCO CON INHERITED WIDGETS

    //*CON STRERAMBUILDER ASCOLTO LO STREAM
    return StreamBuilder<User?>(
      stream: auth.authStateChanged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user != null ? const HomePage() : SignInPage();
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
