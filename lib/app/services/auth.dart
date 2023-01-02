import 'package:firebase_auth/firebase_auth.dart';

//*Definisco interfaccia indipendente da Firebase
abstract class AuthBase {
  User? get currentUser;
  Future<User> signInAnonymously();
  Future<void> signOut();
}

//* la class Auth CENTRALIZZA le chiamate a FIREBASE AUTH
//* UN DOMANI POSSO CAMBIARE PROVIDER DI AUTH
//* I WIDGET CHIEDONO Una istanza di Auth per funzionare
//* USO LA DEPENDENCY INJECTION
class AuthFireBase implements AuthBase {
  //*per non chiamare tutte le volte FirebaseAuth.instance la salvo:
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user!;
  }

  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }
}
