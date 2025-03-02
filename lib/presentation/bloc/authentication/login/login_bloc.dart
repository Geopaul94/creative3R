import 'package:bloc/bloc.dart';
import 'package:creative/data/models/userModel/authentication_model.dart';
import 'package:creative/data/repository/authentication/auth_service.dart';
import 'package:creative/presentation/bloc/authentication/login/login_event.dart';
import 'package:creative/presentation/bloc/authentication/login/login_state.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';


class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<OnLogingButtonPressedEvent>(_onLoginbuttonPressed);

    on<OnForgotPasswordButtonPressedEvent>(_onForgotPasswordButtonPressed);
  }

}
Future<void> _onLoginbuttonPressed(
    OnLogingButtonPressedEvent Event, Emitter<LoginState> emit) async {
  emit(LoginLoadingState());
  try {

    await AuthService().login(Event.userAuthenticationModel);
    emit(LoginSucessState());
  } catch (e) {
    emit(LoginErrorState(error: e.toString()));
  }
}

Future<void> _onForgotPasswordButtonPressed(
    OnForgotPasswordButtonPressedEvent Event, Emitter<LoginState> emit) async {
  emit(ForgotPasswordLoadingState());
  try {

    await AuthService().updatePassword(Event.forgotpassowrd);
    emit(ForgotPasswordSucessState());
  } catch (e) {
    emit(ForgotPasswordErrorState(error: e.toString()));
  }
}
