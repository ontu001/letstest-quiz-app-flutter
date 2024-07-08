import 'package:flutter/material.dart';
import 'package:letstest/screens/quiz_create.dart';
import 'package:letstest/services/database.dart';
import '../utils/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService databaseService = DatabaseService();
  Stream getQuizes = Stream.empty();
  bool hasError = false;

  @override
  void initState() {
    super.initState();
    databaseService.getQuizes().then((value) {
      setState(() {
        getQuizes = value;
        hasError = false;
      });
    }).catchError((error) {
      // Handle the error and set hasError to true
      setState(() {
        hasError = true;
      });
    });
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
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => const QuizCreate()),
              );
            },
            icon: const Icon(
              Icons.add,
              color: kCommonColor,
            ),
          )
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: hasError
            ? const Center(
          child: Text(
            'Failed to load quizzes. Please try again later.',
            style: TextStyle(color: kCommonColor),
          ),
        )
            : StreamBuilder(
          stream: getQuizes,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(
                  color: kCommonColor,
                ),
              );
            }
            if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
              return const Center(
                child: Text(
                  'No quizzes available.',
                  style: TextStyle(color: kCommonColor),
                ),
              );
            }
            var quizDocs = snapshot.data.docs;
            return ListView.builder(
              itemCount: quizDocs.length,
              itemBuilder: (context, index) {
                var quizData = quizDocs[index].data();
                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text(quizData['quizTitle']),
                    subtitle: Text(quizData['quizDesc']),
                    leading: Image.network(
                      quizData['quizImgUrl'],
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
