import 'dart:async';

class SignInBloc {
  final StreamController _isLoadingController = StreamController<bool>();
  Stream<bool> get isLoadingStream =>
      _isLoadingController.stream as Stream<bool>;

  void dispose() {
    _isLoadingController.close();
  }

  void setIsLoading(bool isLoading) => _isLoadingController.add(isLoading);
}
