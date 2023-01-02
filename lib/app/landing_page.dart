import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/home_page.dart';
import 'package:time_tracker/app/sign_in/signin_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //*variabile di stato per vedere se loggato
  User? _user;
  //*definisco la funzione che prenderà (nel widget a cui la passo) in input lo user
  void _updateUser(User? user) {
    setState(() {
      _user = user;
    });
  }
  //* Home page e SignIn page hanno nel loro costruttore delle callback!
  //* sono funzioni ma appartengono alla LandinPage!

  @override
  Widget build(BuildContext context) {
    return _user != null
        ? HomePage(onSignOut: (() => _updateUser(null)))
        : SignInPage(
            onSignIn: _updateUser); //*al momento manda solo alla signIn
  }
}
