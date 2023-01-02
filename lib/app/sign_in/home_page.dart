import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final VoidCallback onSignOut;
  const HomePage({super.key, required this.onSignOut});

  Future<void> _signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      onSignOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          TextButton(
              onPressed: _signOut,
              child: const Text(
                'Logout',
                style: TextStyle(fontSize: 18.0, color: Colors.white),
              ))
        ],
        // centerTitle: true,
      ),
    );
  }
}
