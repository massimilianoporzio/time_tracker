import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_page.dart';
import 'package:time_tracker/app/sign_in/signin_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';

//LA FACCIO DIPENDERE DALLA AUTH BASE
//e primo appraccio mando auth a tutti i sotto wisget che ne hanno bisogno

class SignInPage extends StatelessWidget {
  final AuthBase auth;
  const SignInPage({super.key, required this.auth});

  Future<void> _signInAnonimously() async {
    try {
      await auth.signInAnonymously();
      // onSignIn(user); //* NON USO PIU CALLBACKS MA STREAMS
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  Future<void> _signInWithFacebook() async {
    try {
      await auth.signInWithFacebook();
    } on Exception catch (e) {
      print(e.toString());
    }
  }

  void _signInWithEmail(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute<void>(
      fullscreenDialog: true, //*slide from the bottom
      builder: (context) => EmailSignInPage(
        auth: auth,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Time Tracker"),
        elevation: 2.0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Sign in",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.w600),
          ),
          const SizedBox(
            height: 48.0,
          ),
          SocialSignInButton(
              text: "Sign in with google",
              assetName: "images/google-logo.png",
              color: Colors.white,
              textColor: Colors.black87,
              onPressed: _signInWithGoogle),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: "Sign in with Faecbook",
              color: const Color(0xFF334092),
              textColor: Colors.white,
              onPressed: _signInWithFacebook),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
              text: "Sign in with email",
              color: Colors.teal[700]!,
              textColor: Colors.white,
              onPressed: () => _signInWithEmail(context)),
          const SizedBox(
            height: 8.0,
          ),
          const Text(
            "or",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 14.0, color: Colors.black87),
          ),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
            text: "Go anonymous",
            color: Colors.lime[700]!,
            textColor: Colors.black,
            onPressed: _signInAnonimously,
          ),
        ],
      ),
    );
  }
}
