import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

//*Definisco interfaccia indipendente da Firebase
abstract class AuthBase {
  User? get currentUser;
  Future<User> signInAnonymously();
  Future<void> signOut();
  Stream<User?> authStateChanged(); //rest stream di User

  //*SOCIALS
  Future<User> signInWithGoogle();
}

//* la class Auth CENTRALIZZA le chiamate a FIREBASE AUTH
//* UN DOMANI POSSO CAMBIARE PROVIDER DI AUTH
//* I WIDGET CHIEDONO Una istanza di Auth per funzionare
//* USO LA DEPENDENCY INJECTION
class AuthFireBase implements AuthBase {
  //*per non chiamare tutte le volte FirebaseAuth.instance la salvo:
  final _firebaseAuth = FirebaseAuth.instance;

  //*USO STREAM
  @override
  Stream<User?> authStateChanged() {
    return _firebaseAuth.authStateChanges();
  }

  @override
  User? get currentUser => _firebaseAuth.currentUser;

  @override
  Future<User> signInAnonymously() async {
    final userCredential = await _firebaseAuth.signInAnonymously();
    return userCredential.user!;
  }

  @override
  Future<void> signOut() async {
    final googleSignIn = GoogleSignIn();
    await googleSignIn.signOut(); //*DA GOOGLE così non ho access token valido
    await _firebaseAuth.signOut(); //*DA FIREBASE
  }

  @override
  Future<User> signInWithGoogle() async {
    final googleSignIn = GoogleSignIn();
    final googleUser = await googleSignIn.signIn();
    if (googleUser != null) {
      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null) {
        final userCredential = await _firebaseAuth.signInWithCredential(
            GoogleAuthProvider.credential(
                idToken: googleAuth.idToken,
                accessToken: googleAuth.accessToken));
        return userCredential.user!;
      } else {
        throw FirebaseAuthException(
            code: 'ERROR_MISSING_GOOGLE_ID_TOKEN',
            message: 'Missing Google ID Token.');
      }
    } else {
      //* non è loggato o non esiste su Google
      throw FirebaseAuthException(
          code: 'ERROR_ABORTED_BY_USER', message: 'Sign in aborted by user.');
    }
  }
}
