import 'package:flutter/material.dart';

class QuizOptionDesignWidgets extends StatefulWidget {
  final String option, description, correctAnswer, optionSelected;

  QuizOptionDesignWidgets(
      {required this.description,
      required this.correctAnswer,
      required this.option,
      required this.optionSelected});

  @override
  _QuizOptionDesignWidgetsState createState() =>
      _QuizOptionDesignWidgetsState();
}

class _QuizOptionDesignWidgetsState extends State<QuizOptionDesignWidgets> {
  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          height: 70,
          padding: EdgeInsets.symmetric(horizontal: 15.0),
          width: MediaQuery.of(context).size.width/1.5,

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            // border: Border.all(
            //     color: widget.optionSelected == widget.description
            //         ? widget.description == widget.correctAnswer
            //         ? Colors.green.withOpacity(0.7)
            //         : Colors.red.withOpacity(0.7)
            //         : Colors.grey,
            //     width: 1.5),
            color: widget.optionSelected == widget.description
                ? widget.description == widget.correctAnswer
                    ? Colors.green.withOpacity(0.7)
                    : Colors.red.withOpacity(0.7)
                : Colors.white,
            // borderRadius: BorderRadius.circular(24)
          ),
          child: Row(
            children: [
              Text(
                widget.option,
                style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? Colors.white
                      : Colors.black87,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                widget.description,
                style: TextStyle(
                  color: widget.optionSelected == widget.description
                      ? Colors.white
                      : Colors.black54,
                  fontSize: 20.0
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

