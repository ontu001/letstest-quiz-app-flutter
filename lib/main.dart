import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:letstest/screens/add-question.dart';
import 'package:letstest/screens/home_screen.dart';
import 'package:letstest/screens/sign_in.dart';
import 'package:letstest/screens/sign_up.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lets Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.orangeAccent
      ),
      home:   AddQuestion(),
    );
  }
}
