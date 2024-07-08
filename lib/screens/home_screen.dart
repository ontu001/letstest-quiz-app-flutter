import 'package:flutter/material.dart';
import 'package:letstest/screens/quiz_create.dart';

import '../utils/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lets Test',
          style: TextStyle(fontSize: 18.0, color: kCommonColor),
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: (){
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>QuizCreate()));
              },
              icon: const Icon(
                Icons.add,
                color: kCommonColor,
              ))
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Column(
        children: [

        ],
      ),
    );
  }
}
