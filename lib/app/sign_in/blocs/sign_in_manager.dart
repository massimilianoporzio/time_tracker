import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import '../../services/auth.dart';

class SignInManager {
  //*metto AuthBase come sua dipendenza
  final AuthBase auth;
  //*NON USO STREAMS MA SOLO VALUE NOTIFIER PER LO STATO ISLOADING
  final ValueNotifier<bool> isLoading;

  SignInManager({required this.isLoading, required this.auth});

  //*creo metodo che accetta una funz come input
  Future<User?> _signIn(Future<User?> Function() signInMethod) async {
    try {
      isLoading.value = true;
      return await signInMethod();
    } catch (e) {
      isLoading.value = false; //*solo in caso di errore!
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
