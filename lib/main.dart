import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:letstest/screens/add-question.dart';
import 'package:letstest/screens/home_screen.dart';
import 'package:letstest/screens/sign_in.dart';
import 'package:letstest/screens/sign_up.dart';
import 'package:letstest/utils/saved_loggedin_user.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    loggedInStatues();
    super.initState();
  }

  loggedInStatues() async {
  SaveUserInfo.getUserLoggedInDetails().then((value){
    setState(() {
      _isLoggedIn = value!;
    });
  });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lets Test',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.orangeAccent),
      home: (_isLoggedIn ?? false) ? HomeScreen() : SignIn(),
    );
  }
}
