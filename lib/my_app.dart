import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iti_project/features/login/bloc/login_bloc.dart';
import 'package:iti_project/features/login/screen/login_screen.dart';
import 'package:iti_project/features/login/auth_repo_login.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => LoginBloc(authLoginRepo: FirebaseAuthLoginService()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Login App',
        // theme: ThemeData(primarySwatch: Colors.deepOrange),
        home: const LoginScreen(),
      ),
    );
  }
}
