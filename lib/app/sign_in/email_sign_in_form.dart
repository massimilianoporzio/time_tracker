import 'package:flutter/material.dart';
import 'package:time_tracker/common_widgets/form_signin_button.dart';

enum EmailSignInFormType { register, signin }

class EmailSignInForm extends StatefulWidget {
  const EmailSignInForm({super.key});

  @override
  State<EmailSignInForm> createState() => _EmailSignInFormState();
}

class _EmailSignInFormState extends State<EmailSignInForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  EmailSignInFormType _formType = EmailSignInFormType.register;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
  }

  void _toggleFormType() {
    setState(() {
      _emailController.clear();
      _passwordController.clear();
      _formType = _formType == EmailSignInFormType.signin
          ? EmailSignInFormType.register
          : EmailSignInFormType.signin;
    });
  }

  void _submit() {
    print('email: ${_emailController.text}');
    print('password: ${_passwordController.text}');
  }

  List<Widget> _buildChildren() {
    final primaryText = _formType == EmailSignInFormType.signin
        ? 'Sign In'
        : 'Create an account';
    final secondaryText = _formType == EmailSignInFormType.signin
        ? 'Need an account? Register'
        : 'Already have an account? Sign in';

    return [
      TextField(
        controller: _emailController,
        decoration: const InputDecoration(
            labelText: 'Email', hintText: 'test@test.com'),
      ),
      const SizedBox(
        height: 8,
      ),
      TextField(
        controller: _passwordController,
        decoration: const InputDecoration(
          labelText: 'Password',
        ),
        obscureText: true,
      ),
      const SizedBox(
        height: 8,
      ),
      FormSubmitButton(
        text: primaryText,
        onPressed: _submit,
      ),
      TextButton(
        onPressed: _toggleFormType,
        child: Text(
          secondaryText,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    ];
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
}
