import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:iti_project/features/login/auth_repo_login.dart'; // ✅ هذا الملف اللي انت عملته
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthLoginRepo authLoginRepo; 

  LoginBloc({required this.authLoginRepo}) : super(LoginInitial()) {
    on<LoginButttonPressedEvent>(_onLogin);
    on<LogoutButttonPressedEvent>(_onLogout);
  }

  Future<void> _onLogin(
    LoginButttonPressedEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(LoginLoadingState());

    try {
      final user = await authLoginRepo.signInWithEmailAndPassword(
        email: event.email.trim(),
        password: event.password.trim(),
      );

      if (user != null) {
        emit(LoginSuccessState(user.email ?? ''));
      } else {
        emit(LoginFaildState('Invalid email or password'));
      }
    } on FirebaseAuthException catch (e) {
      emit(LoginFaildState(e.message ?? 'Login failed'));
    } catch (e) {
      emit(LoginFaildState('An unexpected error occurred'));
    }
  }

  void _onLogout(LogoutButttonPressedEvent event, Emitter<LoginState> emit) {
    emit(LoginInitial());
  }
}
