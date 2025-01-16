import 'package:flutter/material.dart';
import 'package:scheduler/screens/home_screen.dart';
import 'package:scheduler/widgets/notifications.dart';

void main() {
  runApp(const MyApp());
  setupGeofenceNotifications();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          primary: Colors.deepPurple,
          secondary: Colors.deepPurpleAccent,
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
