import 'package:flutter/material.dart';
import 'screens/math_screen.dart';
import 'core/app_theme.dart';

void main() {
  runApp(const MathApp());
}

class MathApp extends StatelessWidget {
  const MathApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bullet Math',
      theme: AppTheme.darkTheme,
      home: const MathScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
} 