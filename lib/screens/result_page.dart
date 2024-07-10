import 'package:flutter/material.dart';
import 'package:letstest/services/database.dart';
import 'package:letstest/utils/const.dart';
import 'package:letstest/widgets/orange_button.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  final String quizId;

  const Results({
    super.key,
    required this.incorrect,
    required this.total,
    required this.correct,
    required this.notattempted,
    required this.quizId,
  });

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  final DatabaseService databaseService = DatabaseService();

  @override
  void initState() {
    super.initState();
    saveAttempt();
  }

  void saveAttempt() async {
    // Fetch the quiz title from Firestore
    DocumentSnapshot quizDoc = await databaseService.getQuizTitle(widget.quizId);
    String quizTitle = quizDoc['quizTitle'];

    Map<String, dynamic> attemptData = {
      'quizId': widget.quizId,
      'quizTitle': quizTitle,
      'correct': widget.correct,
      'incorrect': widget.incorrect,
      'notattempted': widget.notattempted,
      'total': widget.total,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await databaseService.addAttemptData(attemptData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${widget.correct} / ${widget.total}",
              style: const TextStyle(fontSize: 25, color: kCommonColor),
            ),
            const SizedBox(height: 5),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "${widget.correct} Correct \n "
                    "${widget.incorrect} Incorrect",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(height: 24),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: customOrangeButton(context, 'Home', width: 200),
            ),
          ],
        ),
      ),
    );
  }
}
