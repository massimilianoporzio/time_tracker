import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/common_widgets/show_alert_dialog.dart';

class HomePage extends StatelessWidget {
  final AuthBase auth;
  const HomePage({super.key, required this.auth});

  Future<void> _confirmSignOut(BuildContext context) async {
    final didRequestSignOut = await showAlertDialog(context,
        title: 'Logout',
        content: "Are you sure that you want to logout?",
        defaultActionText: 'Logout',
        cancelActionText: 'Cancel');
    if (didRequestSignOut!) {
      _signOut();
    }
  }

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
              onPressed: () => _confirmSignOut(context),
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
