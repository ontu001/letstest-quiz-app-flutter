import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:letstest/model/question_model.dart';
import 'package:letstest/services/database.dart';
import 'package:letstest/widgets/quiz_option_design_widgets.dart';

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
        print("$total this is total ${widget.quizId}");
      });
    } catch (error) {
      print("Error fetching quiz data: $error");
    }
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(15.0),
        child: querySnapshot == null
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: ListView.builder(
                  itemCount: querySnapshot!.docs.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder<QuestionModel>(
                      future: getQuestionModelFromSnapshot(
                          querySnapshot!.docs[index]),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          print("Error: ${snapshot.error}");
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.hasData) {
                          return QuizRunWidget(
                            questionModel: snapshot.data!,
                          );
                        } else {
                          return Center(child: Text('No Data Available'));
                        }
                      },
                    );
                  },
                ),
              ),
      ),
    );
  }
}

class QuizRunWidget extends StatefulWidget {
  final QuestionModel questionModel;
  QuizRunWidget({required this.questionModel});

  @override
  State<QuizRunWidget> createState() => _QuizRunWidgetState();
}

class _QuizRunWidgetState extends State<QuizRunWidget> {
  String? optionSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          widget.questionModel.question ?? '',
          style: TextStyle(fontSize: 22.0),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                !widget.questionModel.answered!) {
              if (widget.questionModel.option1 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                widget.questionModel.answered = true;
                correct = correct + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option1;
                widget.questionModel.answered = true;
                incorrect = incorrect + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: QuizOptionDesignWidgets(
            description: widget.questionModel.option1 ?? '',
            correctAnswer: widget.questionModel.correctOption ?? '',
            option: 'A',
            optionSelected: optionSelected.toString(),
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                !widget.questionModel.answered!) {
              if (widget.questionModel.option2 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                widget.questionModel.answered = true;
                correct = correct + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option2;
                widget.questionModel.answered = true;
                incorrect = incorrect + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: QuizOptionDesignWidgets(
            description: widget.questionModel.option2 ?? '',
            correctAnswer: widget.questionModel.correctOption ?? '',
            option: 'B',
            optionSelected: optionSelected.toString(),
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                !widget.questionModel.answered!) {
              if (widget.questionModel.option3 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                widget.questionModel.answered = true;
                correct = correct + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option3;
                widget.questionModel.answered = true;
                incorrect = incorrect + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: QuizOptionDesignWidgets(
            description: widget.questionModel.option3 ?? '',
            correctAnswer: widget.questionModel.correctOption ?? '',
            option: 'C',
            optionSelected: optionSelected.toString(),
          ),
        ),
        SizedBox(height: 5),
        GestureDetector(
          onTap: () {
            if (widget.questionModel.answered != null &&
                !widget.questionModel.answered!) {
              if (widget.questionModel.option4 ==
                  widget.questionModel.correctOption) {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                widget.questionModel.answered = true;
                correct = correct + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              } else {
                optionSelected = widget.questionModel.option4;
                widget.questionModel.answered = true;
                incorrect = incorrect + 1;
                notAttempted = notAttempted - 1;
                setState(() {});
              }
            }
          },
          child: QuizOptionDesignWidgets(
            description: widget.questionModel.option4 ?? '',
            correctAnswer: widget.questionModel.correctOption ?? '',
            option: 'D',
            optionSelected: optionSelected.toString(),
          ),
        ),
      ],
    );
  }
}
