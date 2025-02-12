import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginScreen extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("로그인")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                bool success = await _auth.signIn("test@test.com", "password123");
                if (success) {
                  Navigator.pushReplacementNamed(context, '/home');
                }
              },
              child: Text("테스트 로그인"),
            ),
          ],
        ),
      ),
    );
  }
}
