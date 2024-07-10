import 'package:flutter/material.dart';
import 'package:letstest/utils/const.dart';
import 'package:letstest/widgets/orange_button.dart';

class Results extends StatefulWidget {
  final int total, correct, incorrect, notattempted;
  const Results(
      {super.key,
      required this.incorrect,
      required this.total,
      required this.correct,
      required this.notattempted});

  @override
  _ResultsState createState() => _ResultsState();
}

class _ResultsState extends State<Results> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "${widget.correct}/ ${widget.total}",
              style: const TextStyle(fontSize: 25, color: kCommonColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                "you answered ${widget.correct} answers correctly and ${widget.incorrect} answeres incorrectly and you not attemped  ${widget.notattempted} ",
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20.0),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: customOrangeButton(context, 'Home', width: 200),
            )
          ],
        ),
      ),
    );
  }
}
