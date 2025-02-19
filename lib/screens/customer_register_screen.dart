import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart'; // ✅ 일반 고객은 홈 화면으로 이동

class CustomerRegisterScreen extends StatefulWidget {
  @override
  _CustomerRegisterScreenState createState() => _CustomerRegisterScreenState();
}

class _CustomerRegisterScreenState extends State<CustomerRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String customerId = "";
  String customerName = "";

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _authService.registerAndLogin(customerId, customerName, "customer");

      // ✅ 회원가입 후 홈 화면으로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("일반 회원가입")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "사용자 ID"),
                validator: (value) => value!.isEmpty ? "ID를 입력하세요" : null,
                onSaved: (value) => customerId = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "이름"),
                validator: (value) => value!.isEmpty ? "이름을 입력하세요" : null,
                onSaved: (value) => customerName = value!,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text("회원가입"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
