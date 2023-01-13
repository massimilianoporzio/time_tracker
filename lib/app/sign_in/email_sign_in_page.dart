import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/email_sign_in_form.dart';

class EmailSignInPage extends StatelessWidget {
  final AuthBase auth;
  const EmailSignInPage({super.key, required this.auth});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Sign In"),
        elevation: 2.0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: EmailSignInForm(
            auth: auth,
          ),
        ),
      ),
    );
    ;
  }
}
