import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:time_tracker/app/sign_in/signin_button.dart';
import 'package:time_tracker/app/sign_in/social_sign_in_button.dart';

class SignInPage extends StatelessWidget {
  final void Function(User?) onSignIn;
  const SignInPage({super.key, required this.onSignIn});

  Future<void> _signInAnonimously() async {
    try {
      final userCredential = await FirebaseAuth.instance.signInAnonymously();
      onSignIn(userCredential.user!);
    } on Exception catch (e) {
      // TODO
      print(e.toString());
    }
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
      body: _buildContent(),
    );
  }

  Widget _buildContent() {
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
              onPressed: () {}),
          const SizedBox(
            height: 8.0,
          ),
          SocialSignInButton(
              assetName: 'images/facebook-logo.png',
              text: "Sign in with Faecbook",
              color: const Color(0xFF334092),
              textColor: Colors.white,
              onPressed: () {}),
          const SizedBox(
            height: 8.0,
          ),
          SignInButton(
              text: "Sign in with email",
              color: Colors.teal[700]!,
              textColor: Colors.white,
              onPressed: () {}),
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
