import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letstest/model/question_model.dart';
import 'package:letstest/screens/home_screen.dart';
import 'package:letstest/screens/result_page.dart';
import 'package:letstest/services/database.dart';
import '../utils/const.dart';
import '../widgets/quiz_run_widget.dart';

class RunQuiz extends StatefulWidget {
  final String quizId;

  RunQuiz({required this.quizId});

  @override
  State<RunQuiz> createState() => _RunQuizState();
}

int total = 0, correct = 0, incorrect = 0, attempted = 0, notAttempted = 0;

class _RunQuizState extends State<RunQuiz> {
  DatabaseService databaseService = new DatabaseService();
  QuerySnapshot? querySnapshot;
  int currentQuestionIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    try {
      QuerySnapshot data = await databaseService.getQuizData(widget.quizId);
      setState(() {
        querySnapshot = data;
        total = querySnapshot?.docs.length ?? 0;
        correct = 0;
        incorrect = 0;
        notAttempted = 0;
        currentQuestionIndex = 0;
      });
    } catch (error) {}
  }

  Future<QuestionModel> getQuestionModelFromSnapshot(
      DocumentSnapshot querySnapshot) async {
    QuestionModel questionModel = new QuestionModel();
    Map<String, dynamic>? data = querySnapshot.data()
    as Map<String, dynamic>?; // Call the data() function and cast to a map
    if (data != null) {
      questionModel.question = data["question"];
    }
    List<String> options = [
      data?["option1"],
      data?["option2"],
      data?["option3"],
      data?["option4"]
    ];
    options.shuffle();

    questionModel.option1 = options.isNotEmpty ? options[0] : '';
    questionModel.option2 = options.length > 1 ? options[1] : '';
    questionModel.option3 = options.length > 2 ? options[2] : '';
    questionModel.option4 = options.length > 3 ? options[3] : '';
    questionModel.correctOption = data?["option1"] ?? '';
    questionModel.answered = false;

    return questionModel;
  }

  void nextQuestion() {
    if (currentQuestionIndex < total - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
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
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: kCommonColor,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (_) => const HomeScreen()));
          },
        ),
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: querySnapshot == null
            ? const Center(child: CircularProgressIndicator())
            : FutureBuilder<QuestionModel>(
          future: getQuestionModelFromSnapshot(
              querySnapshot!.docs[currentQuestionIndex]),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print("Error: ${snapshot.error}");
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  QuizRunWidget(
                    index: currentQuestionIndex,
                    questionModel: snapshot.data!,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: previousQuestion,
                        child: const Text('Previous',style: TextStyle(color: kCommonColor)),
                      ),
                      ElevatedButton(
                        onPressed: nextQuestion,
                        child: const Text('Next',style: TextStyle(color: kCommonColor),),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Center(child: Text('No Data Available'));
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: kCommonColor,
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (_) => Results(
                      incorrect: incorrect,
                      total: total,
                      correct: correct,
                      notattempted: notAttempted)));
        },
        child: const Icon(Icons.check, color: Colors.white),
      ),
    );
  }
}
