import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static String routeName = "homePage";
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome Home !",
          style: TextStyle(
            fontSize: 35,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
