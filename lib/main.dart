
import 'package:auth_api/features/authentication/domain/Reoposetory/login_repo.dart';
import 'package:auth_api/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:auth_api/features/authentication/presentation/screens/login_page.dart';
import 'package:auth_api/features/authentication/presentation/screens/register_page.dart';
import 'package:auth_api/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/authentication/domain/Reoposetory/register_repo.dart';
import 'features/authentication/domain/Reoposetory/update_repo.dart';
import 'features/authentication/presentation/screens/update_page.dart';


void main() {
  LoginRepo auth = LoginRepo();
  auth.login(email: "kareem209907@gmail.com", password: "22315564Km@");
  RegisterRepo registerRepo = RegisterRepo();

  // Creating the location map
  Map<String, dynamic> location = {
    "name": "Egypt",
    "address": "meet halfa",
    "coordinates": [1214451511, 12541845]
  };


  registerRepo.register(name: "kareem", email: "kareem209907@gmail.com", phone: "01022876456", password: "22315564Km@",confirmPassword:"22315564Km@", location: location);
  runApp(const AuthApp());
}

class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => AuthenticationBloc(LoginRepo(), RegisterRepo(),UserService(),)),
      ],
      child: MaterialApp(
        initialRoute: LoginPage.routName,
        debugShowCheckedModeBanner: false,
        routes: {
          RegisterPage.routName: (context) => const RegisterPage(),
          LoginPage.routName: (context) => const LoginPage(),
          Home.routeName: (context) => const Home(),
          UpdateUserPage.routeName: (context) => const UpdateUserPage(),
        },
      ),
    );
  }
}
