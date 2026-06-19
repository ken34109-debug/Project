import 'package:flutter/material.dart';
import 'login.dart';
import 'sign.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF030421), Color(0xFF000054)],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.account_circle, size: 150, color: Colors.white),
            const SizedBox(height: 50),
            
            // ปุ่ม Login -> ไปหน้า login.dart
            GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
              child: const Text(
                'Login',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            
            const SizedBox(height: 10),

            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const SignUpPage()));
              },
              child: const Text(
                'Create Account',
                style: TextStyle(color: Colors.lightBlue, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}