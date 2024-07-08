
import 'package:flutter/material.dart';
import 'package:letstest/screens/quiz_create.dart';

import '../utils/const.dart';
import '../widgets/custom_text_form_filed.dart';
import '../widgets/orange_button.dart';

class AddQuestion extends StatefulWidget {
  const AddQuestion({super.key});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  final _keyForm = GlobalKey<FormState>();
  late String question, option1, option2, option3, option4;
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
                context, MaterialPageRoute(builder: (_) => QuizCreate()));
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
                hintText: 'Question',
                obscureText: false,
                onChanged: (value) {
                  question = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "Where is the question?" : null;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: 'Option 1 (It shoud be the correct Answer)',
                obscureText: false,
                onChanged: (value) {
                  option1 = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "What Will be the option1?" : null;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: 'Option 2',
                obscureText: false,
                onChanged: (value) {
                  option2 = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "What Will be the option2?" : null;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: 'Option 3',
                obscureText: false,
                onChanged: (value) {
                  option2 = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "What Will be the option 3?" : null;
                },
              ),
              const SizedBox(
                height: 15.0,
              ),
              CustomTextFormField(
                hintText: 'Option 4',
                obscureText: false,
                onChanged: (value) {
                  option2 = value;
                },
                validator: (value) {
                  return value!.isEmpty ? "What Will be the option 4?" : null;
                },
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                      onTap: () {

                      },
                      child: customOrangeButton(context, 'Submit',width: 200)),

                  GestureDetector(
                      onTap: () {

                      },
                      child: customOrangeButton(context, 'Add Question',width: 200))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
