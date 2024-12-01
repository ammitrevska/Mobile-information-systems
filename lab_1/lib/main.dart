import 'package:flutter/material.dart';
import 'package:lab_1/screens.dart/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.teal[500],
          foregroundColor: Colors.white,
          titleTextStyle: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 24.0,
          ),
        ),
        scaffoldBackgroundColor: Colors.white70,
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}
