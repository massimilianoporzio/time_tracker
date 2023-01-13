//* mi serve come ancestor di material App per fare cercare
//* a flutter la mia istanza di auth da usare nei widget che ne hanno bisogno
import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';

class AuthProvider extends InheritedWidget {
  const AuthProvider({super.key, required this.auth, required Widget child})
      : super(child: child);

  final AuthBase auth;

  @override
  bool updateShouldNotify(covariant InheritedWidget oldWidget) {
    return false; //* per ora
  }

  static AuthBase of(BuildContext context) {
    AuthProvider? provider =
        context.dependOnInheritedWidgetOfExactType<AuthProvider>();
    if (provider != null) {
      return provider.auth;
    } else {
      throw StateError('Could not find ancestor widget of type `AuthProvider`');
    }
  }
}
