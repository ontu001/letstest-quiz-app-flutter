import 'package:flutter/material.dart';
import 'package:letstest/screens/sign_in.dart';
import 'package:letstest/screens/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lest Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orangeAccent
      ),
      home:  const SignUp(),
    );
  }
}
