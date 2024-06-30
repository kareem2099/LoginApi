import 'package:auth_api/features/authentication/presentation/bloc/authentication_bloc.dart';
import 'package:auth_api/features/authentication/presentation/components/text_format_field.dart';
import 'package:auth_api/features/authentication/presentation/components/password_form_field.dart';
import 'package:auth_api/features/authentication/presentation/screens/register_page.dart';
import 'package:auth_api/features/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  static String routName = "LoginPage";

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  AuthenticationBloc? auth;
  GlobalKey<FormState> emailKey = GlobalKey();
  GlobalKey<FormState> passwordKey = GlobalKey();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    auth = BlocProvider.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Container(
              width: MediaQuery.of(context).size.width / 1.5,
              height: MediaQuery.of(context).size.height / 3,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage("assets/login.gif"),
              )),
            ),
            TextFromatField(
              fKey: emailKey,
              controller: email,
              label: "email",
            ),
            PasswordFormatField(
              fKey: passwordKey,
              label: "password",
              controller: password,
            ),
            BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                setState(() {
                  isLoading = state is AuthenticationLoading;
                });
                if (state is AuthenticationSuccess) {
                  Navigator.pushNamed(context, Home.routeName);
                } else if (state is AuthenticationError) {
                  showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          content: Text(state.message),
                        );
                      });
                }
              },
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 10,
                  backgroundColor: Colors.green,
                ),
                onPressed: () {
                  if (emailKey.currentState!.validate() &&
                      passwordKey.currentState!.validate()) {
                    auth!.add(
                        LoginEvent(email: email.text, password: password.text));
                  }
                },
                child: isLoading
                    ? const CircularProgressIndicator()
                    : const Text(
                        "LogIn",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("If you don't have an account: "),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, RegisterPage.routName);
                    },
                    child: const Text(
                      "SignUp",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
