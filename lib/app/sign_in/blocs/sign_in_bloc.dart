import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_tracker/app/services/auth.dart';

class SignInBloc {
  //*metto AuthBase come sua dipendenza
  final AuthBase auth;
  final StreamController _isLoadingController = StreamController<bool>();

  SignInBloc({required this.auth});
  Stream<bool> get isLoadingStream =>
      _isLoadingController.stream as Stream<bool>;

  void dispose() {
    _isLoadingController.close();
  }

  void _setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
  //*creo metodo che accetta una funz come input
  Future<User?> _signIn(Future<User?> Function() signInMethod) async {
    try {
      _setIsLoading(true);
      return await signInMethod();
    } catch (e) {
      _setIsLoading(false); //*solo in caso di errore!
      rethrow;
    } finally {
      //*lo stream viene chiuso in caso di successo perché la signin page viene
      //* tolta dall'albero dei widget perché finisco sulla home page
    }
  }

  Future<User?>? signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);

  Future<User?>? signInWithGoogle() async =>
      await _signIn(auth.signInWithGoogle);

  Future<User?>? signInWithFacebook() async =>
      await _signIn(auth.signInWithFacebook);
}
