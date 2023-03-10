import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'show_alert_dialog.dart';

Future<void> showExceptionAlertDialog(BuildContext context,
    {required String title, required Exception exception}) {
  return showAlertDialog(
    context,
    title: title,
    content: _message(exception),
    defaultActionText: 'OK',
  );
}

String _message(Exception exception) {
  if (exception is FirebaseException) {
    return exception.message!;
  } else {
    return exception.toString();
  }
}
