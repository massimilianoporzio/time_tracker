import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/home_page.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/signin_page.dart';

class LandingPage extends StatefulWidget {
  final AuthBase auth;
  const LandingPage({super.key, required this.auth});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  //*variabile di stato per vedere se loggato
  User? _user;

  @override
  void initState() {
    super.initState();
    // //*ASCOLTO LO STREAM DI USER..QUANDO ARRIVA QUALCOSA INVOCO FUNZIONE
    // widget.auth.authStateChanges().listen((user) {
    //   print('uid: ${user?.uid}');
    // });
    //*CONTROLLO SE SONO GIA' LOGGATO
    _updateUser(widget.auth.currentUser);
  }

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
    //*CON STRERAMBUILDER ASCOLTO LO STREAM
    return StreamBuilder<User?>(
      stream: widget.auth.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final User? user = snapshot.data;
          return user != null
              ? HomePage(
                  auth: widget.auth, onSignOut: (() => _updateUser(null)))
              : SignInPage(auth: widget.auth, onSignIn: _updateUser);
        }
        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
