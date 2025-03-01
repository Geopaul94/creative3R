part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class OnLogingButtonPressedEvent extends LoginEvent {

final UserAuthenticationModel userAuthenticationModel;

  OnLogingButtonPressedEvent({required this.userAuthenticationModel});

}

class OnForgotPasswordButtonPressedEvent extends LoginEvent {
  final String password;

  OnForgotPasswordButtonPressedEvent({required this.password});
}
