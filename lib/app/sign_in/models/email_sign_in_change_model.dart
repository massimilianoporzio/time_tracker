import 'package:flutter/foundation.dart';

import '../validators.dart';
import 'email_sign_in_model.dart';

class EmailSignInChangeModel with EmailAndPasswordValidator, ChangeNotifier {
  final String email;
  final String password;
  final EmailSignInFormType formType;
  final bool isLoading;
  final bool submitted;

  String? get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErroText : null;
  }

  String? get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErroText : null;
  }

  bool get canSubmit {
    return emailValidator.isValid(email) &&
        passwordValidator.isValid(password) &&
        !isLoading;
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signin
        ? 'Sign In'
        : 'Create an account';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signin
        ? 'Need an account? Register'
        : 'Already have an account? Sign in';
  }

  EmailSignInChangeModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signin,
      this.isLoading = false,
      this.submitted = false});

  //*crea una copia con i valori nuovi se forniti se no gli originali
  EmailSignInChangeModel copyWith(
      {String? email,
      String? password,
      EmailSignInFormType? formType,
      bool? isLoading,
      bool? submitted}) {
    return EmailSignInChangeModel(
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted);
  }
}
