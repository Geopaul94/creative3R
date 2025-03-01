import 'package:bloc/bloc.dart';
import 'package:creative/data/models/userModel/authentication_model.dart';
import 'package:flutter/services.dart';
import 'package:meta/meta.dart';

part 'login_event.dart';
part 'login_state.dart';

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
    emit(LoginSucessState());
  } catch (e) {
    emit(LoginErrorState(error: e.toString()));
  }
}

Future<void> _onForgotPasswordButtonPressed(
    OnForgotPasswordButtonPressedEvent Event, Emitter<LoginState> emit) async {
  emit(ForgotPasswordLoadingState());
  try {
    emit(ForgotPasswordSucessState());
  } catch (e) {
    emit(ForgotPasswordErrorState(error: e.toString()));
  }
}
