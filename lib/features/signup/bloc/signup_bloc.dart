import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:iti_project/features/signup/auth_repo_signup.dart';
import 'package:meta/meta.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final AuthRepo authRepo;

  SignUpBloc({required this.authRepo}) : super(SignUpInitial()) {
    on<SignUpSubmittedEvent>(_onSignUpSubmitted);
    on<SignUpReset>(_onSignUpReset);
    on<InitiSingUpScreenEvent>(_onSignUpIniti);
  }

  Future<void> _onSignUpSubmitted(
    SignUpSubmittedEvent event,
    Emitter<SignUpState> emit,
  ) async {
    if (event.email.isEmpty ||
        event.password.isEmpty ||
        event.confirmPassword.isEmpty ||
        event.name.isEmpty) {
      emit(SignUpFailure('All fields are required'));
      return;
    }

    if (!event.email.contains('@')) {
      emit(SignUpFailure('Please enter a valid email'));
      return;
    }

    if (event.password.length < 6) {
      emit(SignUpFailure('Password must be at least 6 characters'));
      return;
    }

    if (event.password != event.confirmPassword) {
      emit(SignUpFailure('Passwords do not match'));
      return;
    }

    emit(SignUpLoading());

    try {
      final user = await authRepo.signUpWithEmailAndPassword(
        email: event.email,
        password: event.password,
        name: event.name,
      );

      if (user != null) {
        emit(SignUpSuccess(user.email ?? ''));
      } else {
        emit(SignUpFailure('Sign up failed. Please try again.'));
      }
    } catch (e) {
      String errorMessage;

      if (e is FirebaseAuthException) {
        switch (e.code) {
          case 'email-already-in-use':
            errorMessage = 'This email is already in use.';
            break;
          case 'invalid-email':
            errorMessage = 'The email address is badly formatted.';
            break;
          case 'weak-password':
            errorMessage = 'The password is too weak.';
            break;
          default:
            errorMessage = e.message ?? 'Authentication failed';
        }
      } else {
        errorMessage = e.toString().replaceFirst('Exception:', '').trim();
      }

      debugPrint("🔥 Signup Error (Bloc): \$errorMessage");
      emit(SignUpFailure(errorMessage));
    }
  }

  void _onSignUpReset(SignUpReset event, Emitter<SignUpState> emit) {
    emit(SignUpInitial());
  }

  void _onSignUpIniti(InitiSingUpScreenEvent event, Emitter<SignUpState> emit) {
    emit(SignUpInitial());
  }
}
