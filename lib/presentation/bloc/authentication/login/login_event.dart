
import 'package:creative/data/models/userModel/authentication_model.dart';

sealed class LoginEvent {}

class OnLogingButtonPressedEvent extends LoginEvent {
  final UserAuthenticationModel userAuthenticationModel;

  OnLogingButtonPressedEvent({required this.userAuthenticationModel});
}

class OnForgotPasswordButtonPressedEvent extends LoginEvent {
  final UserAuthenticationModel forgotpassowrd;

  OnForgotPasswordButtonPressedEvent({required this.forgotpassowrd});

 
}
