import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  Future<void> addQuizData(Map<String, dynamic> quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .set(quizData)
        .catchError((e) {
      print(e);
    });
  }

  Future<void> addQuestionData(quizData, String quizId) async {
    await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QUESSTION AND ANSWER")
        .add(quizData)
        .catchError((e) {
      print(e);
    });
  }

  getQuizes() async {
    return await FirebaseFirestore.instance.collection("Quiz").snapshots();
  }

  Future<QuerySnapshot> getQuizData(String quizId) async {
    return await FirebaseFirestore.instance
        .collection("Quiz")
        .doc(quizId)
        .collection("QUESSTION AND ANSWER")
        .get();
  }
}
