import 'package:flutter/material.dart';
import 'package:letstest/screens/add-question.dart';
import 'package:letstest/screens/home_screen.dart';
import 'package:letstest/services/database.dart';
import 'package:letstest/widgets/orange_button.dart';
import 'package:random_string/random_string.dart';
import '../utils/const.dart';
import '../widgets/custom_text_form_filed.dart';

class QuizCreate extends StatefulWidget {
  const QuizCreate({super.key});

  @override
  State<QuizCreate> createState() => _QuizCreateState();
}

class _QuizCreateState extends State<QuizCreate> {
  final _keyForm = GlobalKey<FormState>();
  DatabaseService databaseService = DatabaseService();
  late String quizPrompt, quizDescription, imageUrl, quizId;
  bool _isLoading = false;

  createQuiz() {
    if (_keyForm.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });
      quizId = randomAlphaNumeric(16);
      Map<String, String> quizData = {
        "quizId": quizId,
        "quizImgUrl": imageUrl,
        "quizTitle": quizPrompt,
        "quizDesc": quizDescription
      };

      databaseService.addQuizData(quizData, quizId).then((value) {
        setState(() {
          _isLoading = false;
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => AddQuestion(
                        quizId: quizId,
                      )));
        });
      });
    }
  }

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
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: kCommonColor,
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(18.0),
              child: Form(
                key: _keyForm,
                child: Column(
                  children: [
                    CustomTextFormField(
                      hintText: 'Image Url',
                      obscureText: false,
                      onChanged: (value) {
                        imageUrl = value;
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
                    GestureDetector(
                        onTap: () {
                          createQuiz();
                        },
                        child: customOrangeButton(context, 'Create Quiz',
                            fullWidth: true)),
                  ],
                ),
              ),
            ),
    );
  }
}
