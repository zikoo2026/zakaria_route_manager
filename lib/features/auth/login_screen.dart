import 'package:flutter/material.dart';
import '../../core/route/zakaria_route_manager.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل الدخول'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const TextField(
              decoration: InputDecoration(
                labelText: 'البريد الإلكتروني',
              ),
            ),
            const SizedBox(height: 10),
            const TextField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'كلمة المرور',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // بعد تسجيل الدخول الناجح
                ZakariaRouteManager().pushAndRemoveUntil('/');
              },
              child: const Text('تسجيل الدخول'),
            ),
          ],
        ),
      ),
    );
  }
}