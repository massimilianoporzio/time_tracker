import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  const HomePage({super.key, required this.auth});

  Future<void> _signOut() async {
    try {
      await auth.signOut();
      // onSignOut(); //*NON USO PIU CALLBACKS MA STREAMS!
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
