import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'blocs/email_sign_in_bloc.dart';

import '../../common_widgets/form_signin_button.dart';
import '../../common_widgets/show_exception_alert_dialog.dart';
import '../services/auth.dart';
import 'models/email_sign_in_model.dart';

class EmailSignInFormBlocBased extends StatefulWidget {
  final EmailSignInBloc bloc;
  const EmailSignInFormBlocBased({super.key, required this.bloc});

  //*metodo create statico
  static Widget create(BuildContext context) {
    //listen false: creo una sola volta e non ricreo al cambio di auth (non cmabia)
    final auth = Provider.of<AuthBase>(context, listen: false);
    return Provider<EmailSignInBloc>(
      create: (_) => EmailSignInBloc(auth: auth),
      //* primo argom il context (non lo uso)
      //*secondo argom il value (in questo caso il bloc che consuma)
      //* terzo argom il child (non lo uso) che è la parte che non cambia con il bloc
      child: Consumer<EmailSignInBloc>(
        builder: (_, bloc, __) => EmailSignInFormBlocBased(bloc: bloc),
      ),
      dispose: (context, bloc) =>
          bloc.dispose(), //*quando distruggo il widget chiudo lo stream
    );
  }

  @override
  State<EmailSignInFormBlocBased> createState() =>
      _EmailSignInFormBlocBasedState();
}

class _EmailSignInFormBlocBasedState extends State<EmailSignInFormBlocBased> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  //*ho rimosso le varib di stato che NON c'entrano con la UI

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  void _toggleFormType() {
    //SE CAMBIO I VALORI NELLO STATO LOCALE
    //LI DEVO CAMBIARE ANCHE NEL MODEL che sta nel bloc
    widget.bloc.toggleFormType();

    _emailController.clear();
    _passwordController.clear();
    FocusScope.of(context).requestFocus(_focusNodeEmail);
  }

  void _submit() async {
    try {
      await widget.bloc.submit();

      if (mounted) {
        Navigator.of(context).pop(); //rimando a pagina
      }
    } on FirebaseAuthException catch (e) {
      showExceptionAlertDialog(
        context,
        title: "Sign in failed",
        exception: e,
      );
    }
  }

  List<Widget> _buildChildren(EmailSignInModel model) {
    return [
      _buildEmailTextField(model),
      const SizedBox(
        height: 8,
      ),
      _buildPasswordTextField(model),
      const SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      TextButton(
        onPressed: model.isLoading ? null : _toggleFormType,
        child: Text(
          model.secondaryButtonText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField(EmailSignInModel model) {
    return TextField(
      controller: _passwordController,
      focusNode: _focusNodePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          enabled: !model.isLoading,
          labelText: 'Password',
          errorText: model.passwordErrorText),
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: widget.bloc.updatePassword,
    );
  }

  TextField _buildEmailTextField(EmailSignInModel model) {
    //guardo se valido

    return TextField(
      controller: _emailController,
      autocorrect: false,
      focusNode: _focusNodeEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: () => _emailEditingComplete(model),
      onChanged: widget.bloc.updateEmail,
      decoration: InputDecoration(
        enabled: !model.isLoading,
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: model.emailErrorText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //lo circondo con uno streambuilder del mio model
    return StreamBuilder<EmailSignInModel>(
        stream: widget.bloc.modelStream, //*è il modello aggiornato
        initialData: EmailSignInModel(),
        builder: (context, snapshot) {
          final EmailSignInModel model = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: _buildChildren(model),
            ),
          );
        });
  }

  void _emailEditingComplete(EmailSignInModel model) {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _focusNodePassword
        : _focusNodeEmail;
    FocusScope.of(context).requestFocus(newFocus);
  }
}
