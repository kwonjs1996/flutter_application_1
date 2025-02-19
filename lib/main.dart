import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'theme.dart'; // 🔹 테마 파일 불러오기

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shortform Platform',
      theme: appTheme, // 🔹 테마 적용
      home: HomeScreen(),
    );
  }
}