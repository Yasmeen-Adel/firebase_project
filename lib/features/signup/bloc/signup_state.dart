part of 'signup_bloc.dart';

@immutable
abstract class SignUpState {}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String email;

  SignUpSuccess(this.email);
}

class SignUpFailure extends SignUpState {
  final String message;

  SignUpFailure(this.message);
}
