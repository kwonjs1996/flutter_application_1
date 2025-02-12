import 'package:flutter/material.dart';

final ThemeData appTheme = ThemeData(
  primaryColor: Color(0xFF0175C2), // Flutter 블루
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: Colors.blue, // 기본 색상
  ).copyWith(
    secondary: Color(0xFF13B9FD), // 강조 색상
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF0175C2), // 버튼 색상
      foregroundColor: Colors.white, // 버튼 텍스트 색상
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    ),
  ),
);
