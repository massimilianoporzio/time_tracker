import 'package:flutter/material.dart';
import 'package:time_tracker/app/services/auth.dart';
import 'package:time_tracker/app/sign_in/validators.dart';
import 'package:time_tracker/common_widgets/form_signin_button.dart';

enum EmailSignInFormType { register, signin }

class EmailSignInForm extends StatefulWidget with EmailAndPasswordValidator {
  final AuthBase auth;
  EmailSignInForm({super.key, required this.auth});

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _focusNodeEmail = FocusNode();
  final _focusNodePassword = FocusNode();

  String get _email => _emailController.text;
  String get _password => _passwordController.text;

  EmailSignInFormType _formType = EmailSignInFormType.signin;
  bool _submitted = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _focusNodeEmail.dispose();
    _focusNodePassword.dispose();
    super.dispose();
  }

  void _toggleFormType() {
    setState(() {
      _submitted = false;
      _emailController.clear();
      _passwordController.clear();
      _formType = _formType == EmailSignInFormType.signin
          ? EmailSignInFormType.register
          : EmailSignInFormType.signin;
    });
  }

  void _submit() async {
    print('submit called');

    setState(() {
      _isLoading = true;
      _submitted = true;
    });
    try {
      //await Future.delayed(const Duration(seconds: 3));
      if (_formType == EmailSignInFormType.signin) {
        await widget.auth.signInWithEmailAndPassword(_email, _password);
      } else {
        await widget.auth.createUserWithEmailAndPassord(_email, _password);
      }

      if (mounted) {
        Navigator.of(context).pop(); //rimando a pagina
      }
    } on Exception catch (e) {
      print(e.toString());
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signin
        ? 'Sign In'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signin
        ? 'Need an account? Register'
        : 'Already have an account? Sign in';

    bool submitEnabled = widget.emailValidator.isValid(_email) &&
        widget.passwordValidator.isValid(_password) &&
        !_isLoading;

    return [
      _buildEmailTextField(),
      const SizedBox(
        height: 8,
      ),
      _buildPasswordTextField(),
      const SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: submitEnabled ? _submit : null,
      ),
      TextButton(
        onPressed: _isLoading ? null : _toggleFormType,
        child: Text(
          secondaryText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ];
  }

  TextField _buildPasswordTextField() {
    bool showErrorText =
        _submitted && !widget.passwordValidator.isValid(_password);
    return TextField(
      controller: _passwordController,
      focusNode: _focusNodePassword,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
          enabled: !_isLoading,
          labelText: 'Password',
          errorText: showErrorText ? widget.invalidPasswordErroText : null),
      obscureText: true,
      onEditingComplete: _submit,
      onChanged: (password) => _updateState(),
    );
  }

  TextField _buildEmailTextField() {
    //guardo se valido
    bool showErrorText = _submitted && !widget.emailValidator.isValid(_email);
    return TextField(
      controller: _emailController,
      autocorrect: false,
      focusNode: _focusNodeEmail,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onEditingComplete: _emailEditingComplete,
      onChanged: (email) => _updateState(),
      decoration: InputDecoration(
        enabled: !_isLoading,
        labelText: 'Email',
        hintText: 'test@test.com',
        errorText: showErrorText ? widget.invalidEmailErroText : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: _buildChildren(),
      ),
    );
  }

  void _emailEditingComplete() {
    final newFocus = widget.emailValidator.isValid(_email)
        ? _focusNodePassword
        : _focusNodeEmail;
    FocusScope.of(context).requestFocus(newFocus);
  }

  _updateState() {
    setState(() {});
  }
}
