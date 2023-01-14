import 'package:time_tracker/app/sign_in/validators.dart';

enum EmailSignInFormType { register, signin }

class EmailSignInModel with EmailAndPasswordValidator {
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

  EmailSignInModel(
      {this.email = '',
      this.password = '',
      this.formType = EmailSignInFormType.signin,
      this.isLoading = false,
      this.submitted = false});

  //*crea una copia con i valori nuovi se forniti se no gli originali
  EmailSignInModel copyWith(
      {String? email,
      String? password,
      EmailSignInFormType? formType,
      bool? isLoading,
      bool? submitted}) {
    return EmailSignInModel(
        email: email ?? this.email,
        password: password ?? this.password,
        formType: formType ?? this.formType,
        isLoading: isLoading ?? this.isLoading,
        submitted: submitted ?? this.submitted);
  }
}
