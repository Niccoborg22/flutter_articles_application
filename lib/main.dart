import 'package:flutter/material.dart';
import 'views/_login.dart';

void main() {
  runApp(const MyApp());
}

// APPLICATION ENTRY POINT
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Articles App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color.fromARGB(41, 204, 5, 204),
      ),
      home: const LoginPage(),
    );
  }
}