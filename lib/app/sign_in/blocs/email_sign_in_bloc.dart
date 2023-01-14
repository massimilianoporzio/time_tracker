import 'dart:async';

import '../../services/auth.dart';
import '../models/email_sign_in_model.dart';

class EmailSignInBloc {
  final AuthBase auth;
  final StreamController<EmailSignInModel> _modelController =
      StreamController<EmailSignInModel>();

  EmailSignInBloc({required this.auth});

  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();
  void dispose() {
    _modelController.close();
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String pass) => updateWith(password: pass);

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signin
        ? EmailSignInFormType.register
        : EmailSignInFormType.signin;
    updateWith(
        email: '',
        password: '',
        isLoading: false,
        submitted: false,
        formType: formType);
  }

  void updateWith({
    String? email,
    String? password,
    EmailSignInFormType? formType,
    bool? isLoading,
    bool? submitted,
  }) {
    //update model con una copia (immutables!)
    _model = _model.copyWith(
        email: email,
        password: password,
        formType: formType,
        isLoading: isLoading,
        submitted: submitted);
    //add updated model to _modelController
    _modelController.add(_model); //*infilo nello stream il "nuovo" model
  }

  //* QUI LA LOGICA di business
  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);
    try {
      //await Future.delayed(const Duration(seconds: 3));
      if (_model.formType == EmailSignInFormType.signin) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassord(_model.email, _model.password);
      }
    } catch (_) {
      updateWith(isLoading: false); //* in caso positivo vado su HOmePage
      rethrow; //*rigiro OGNI errore
    }
  }
}
