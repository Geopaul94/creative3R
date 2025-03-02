
sealed class LoginState {}

final class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState({required this.error});
}

class LoginSucessState extends LoginState {}

class ForgotPasswordLoadingState extends LoginState {}

class ForgotPasswordSucessState extends LoginState {}

class ForgotPasswordErrorState extends LoginState {
  final String error;

  ForgotPasswordErrorState({required this.error});
}
