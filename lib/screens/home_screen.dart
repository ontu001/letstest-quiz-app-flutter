import 'package:flutter/material.dart';
import 'package:letstest/screens/quiz_create.dart';
import 'package:letstest/screens/quiz_update.dart';
import 'package:letstest/screens/run_quiz.dart';
import 'package:letstest/screens/sign_in.dart';
import 'package:letstest/services/authentication.dart';
import 'package:letstest/services/database.dart';
import 'package:letstest/widgets/attempt_summar_widgets.dart';
import '../utils/const.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final DatabaseService databaseService = DatabaseService();
  Stream getQuizes = Stream.empty();
  Stream getAttempts = Stream.empty();
  bool hasError = false;
  AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    databaseService.getQuizes().then((value) {
      setState(() {
        getQuizes = value;
        hasError = false;
      });
    }).catchError((error) {
      setState(() {
        hasError = true;
      });
    });

    databaseService.getAttempts().then((value) {
      setState(() {
        getAttempts = value;
        hasError = false;
      });
    }).catchError((error) {
      setState(() {
        hasError = true;
      });
    });
  }

  void deleteQuiz(String quizId) async {
    await databaseService.deleteQuiz(quizId);
    setState(() {
      getQuizes = databaseService.getQuizes();
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
        leading: IconButton(
          icon: const Icon(
            Icons.add,
            color: kCommonColor,
          ),
          onPressed: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => QuizCreate()));
          },
        ),
        actions: [
          IconButton(
            onPressed: () {
              authService.signOut();
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (_) => SignIn()));
            },
            icon: const Icon(
              Icons.logout,
              color: kCommonColor,
            ),
          ),
        ],
        automaticallyImplyLeading: false,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: hasError
            ? const Center(
          child: Text(
            'Failed to load quizzes or attempts. Please try again later.',
            style: TextStyle(color: kCommonColor),
          ),
        )
            : Column(
          children: [
            const Text(
              'Quizzes',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            Expanded(
              flex: 2,
              child: StreamBuilder(
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
                      var quizId = quizDocs[index].id;
                      return Card(
                        elevation: 4,
                        child: ListTile(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => RunQuiz(
                                      quizId: quizId,
                                    )));
                          },
                          title: Text(quizData['quizTitle'] ?? 'No Title',style: TextStyle(fontWeight: FontWeight.bold),),
                          subtitle: Text(quizData['quizDesc'] ?? 'No Description'),
                          trailing: PopupMenuButton(
                            onSelected: (value) {
                              if (value == 'edit') {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (_) => QuizUpdate(
                                          quizId: quizId,
                                          quizData: quizData,
                                        )));
                              } else if (value == 'delete') {
                                deleteQuiz(quizId);
                              }
                            },
                            itemBuilder: (context) => [
                              PopupMenuItem(
                                value: 'edit',
                                child: Text('Edit'),
                              ),
                              PopupMenuItem(
                                value: 'delete',
                                child: Text('Delete'),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 80),
            const Text(
              'Summary',
              style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
            ),
            AttemptsSummaryWidget(attemptsStream: getAttempts)
          ],
        ),
      ),
    );
  }
}
