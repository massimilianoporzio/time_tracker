import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'app/landing_page.dart';
import 'app/services/auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
      );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider<AuthBase>(
      create: (context) => AuthFireBase(),
      //*la inietto qui non serve più passarla negli altri widget
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
        ),
        //* QUI DEPENDENCY INJECTION inietto l'auth firebase
        //*un domani posso cambiare SOLO QUI e tutto funziona
        home: const LandingPage(),
      ),
    );
  }
}
