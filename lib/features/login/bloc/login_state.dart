part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final String email;
  LoginSuccessState(this.email);
}

class LoginFaildState extends LoginState {
  final String msg;
  LoginFaildState(this.msg);
}
