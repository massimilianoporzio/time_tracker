abstract class StringValidator {
  bool isValid(String value);
}

class NotEmptyStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }
}

class EmailAndPasswordValidator {
  final StringValidator emailValidator = NotEmptyStringValidator();
  final StringValidator passwordValidator = NotEmptyStringValidator();
  final String invalidEmailErroText = 'Email cannot be empty';
  final String invalidPasswordErroText = 'Password cannot be empty';
}
