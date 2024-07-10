import 'package:flutter/material.dart';
import 'package:letstest/model/question_model.dart';
import 'package:letstest/widgets/quiz_option_design_widgets.dart';

import '../screens/run_quiz.dart';
class QuizRunWidget extends StatefulWidget {
  final QuestionModel questionModel;
  final int index;
  QuizRunWidget({required this.questionModel, required this.index});

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