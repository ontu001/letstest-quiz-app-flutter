import 'package:flutter/material.dart';

class AttemptsSummaryWidget extends StatelessWidget {
  final Stream attemptsStream;

  const AttemptsSummaryWidget({Key? key, required this.attemptsStream}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: StreamBuilder(
        stream: attemptsStream,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            );
          }
          if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
            return const Center(
              child: Text(
                'No attempts available.',
                style: TextStyle(color: Colors.blue),
              ),
            );
          }
          var attemptDocs = snapshot.data.docs;
          return PageView.builder(
            itemCount: attemptDocs.length,
            itemBuilder: (context, index) {
              var attemptData = attemptDocs[index].data();
              return Card(
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quiz: ${attemptData['quizTitle'] ?? 'No Title'}',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Correct: ${attemptData['correct'] ?? '0'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Incorrect: ${attemptData['incorrect'] ?? '0'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Not Attempted: ${attemptData['notattempted'] ?? '0'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Total: ${attemptData['total'] ?? '0'}',
                        style: TextStyle(fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Date: ${attemptData['timestamp']?.toDate() ?? 'No Date'}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
