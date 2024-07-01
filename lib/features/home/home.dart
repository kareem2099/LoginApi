import 'package:flutter/material.dart';
import '../authentication/presentation/screens/update_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});
  static String routeName = "homePage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome Home!",
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, UpdateUserPage.routeName);
              },
              child: const Text('Update User'),
            ),
          ],
        ),
      ),
    );
  }
}
