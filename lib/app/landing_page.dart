import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'services/auth.dart';
import 'sign_in/signin_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    //*listen:false qui non ho uno stato da tenere aggiornato
    final auth =
        Provider.of<AuthBase>(context, listen: false); //LA CERCO CON PROVIDER

    //*CON STRERAMBUILDER ASCOLTO LO STREAM
    return StreamBuilder<User?>(
      stream: auth.authStateChanged(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user != null ? const HomePage() : SignInPage.create(context);
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
