part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

class LoginButttonPressedEvent extends LoginEvent {
  final String email;
  final String password;
  LoginButttonPressedEvent(this.email, this.password);
}

class LogoutButttonPressedEvent extends LoginEvent {}
