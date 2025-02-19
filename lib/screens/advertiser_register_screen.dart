import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import 'home_screen.dart'; // ✅ 광고주 회원가입 후 대시보드로 이동

class AdvertiserRegisterScreen extends StatefulWidget {
  @override
  _AdvertiserRegisterScreenState createState() => _AdvertiserRegisterScreenState();
}

class _AdvertiserRegisterScreenState extends State<AdvertiserRegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  String advertiserId = "";
  String advertiserName = "";

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      await _authService.registerAndLogin(advertiserId, advertiserName, "advertiser");

      // ✅ 회원가입 후 광고주 대시보드로 이동
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("광고주 회원가입")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: "광고주 ID"),
                validator: (value) => value!.isEmpty ? "ID를 입력하세요" : null,
                onSaved: (value) => advertiserId = value!,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "회사명"),
                validator: (value) => value!.isEmpty ? "회사명을 입력하세요" : null,
                onSaved: (value) => advertiserName = value!,
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
