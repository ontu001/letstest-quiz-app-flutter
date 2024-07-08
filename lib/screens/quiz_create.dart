import 'package:flutter/material.dart';
import 'package:letstest/screens/home_screen.dart';
import 'package:letstest/widgets/orange_button.dart';

import '../utils/const.dart';
import '../widgets/custom_text_form_filed.dart';

class QuizCreate extends StatefulWidget {
  const QuizCreate({super.key});

  @override
  State<QuizCreate> createState() => _QuizCreateState();
}

class _QuizCreateState extends State<QuizCreate> {
  final _keyForm = GlobalKey<FormState>();
  late String quizPrompt, quizDescription, imageUrl;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lets Test',
          style: TextStyle(fontSize: 18.0, color: kCommonColor),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: kCommonColor,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kCommonColor,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => HomeScreen()));
          },
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Form(
          key: _keyForm,
          child: Column(
            children: [
              CustomTextFormField(
                hintText: 'Image Url',
                obscureText: false,
                onChanged: (value) {
                  quizPrompt = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "image url" : null;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: 'Quiz Title',
                obscureText: false,
                onChanged: (value) {
                  quizPrompt = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "What Will be the tile?" : null;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: 'Quiz Description',
                obscureText: false,
                onChanged: (value) {
                  quizDescription = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "Description please" : null;
                },
              ),
              const Spacer(),
              customOrangeButton(context, 'Create Quiz'),
            ],
          ),
        ),
      ),
    );
  }
}
