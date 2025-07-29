import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_project/features/login/bloc/login_bloc.dart';
import 'package:iti_project/features/login/screen/login_screen_conent.dart';
import 'package:iti_project/features/login/auth_repo_login.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginBloc(authLoginRepo: FirebaseAuthLoginService()),
      child: const Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(child: LoginScreenContent()),
      ),
    );
  }
}
