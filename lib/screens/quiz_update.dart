import 'package:flutter/material.dart';
import 'package:letstest/services/database.dart';
import 'package:letstest/widgets/orange_button.dart';
import '../utils/const.dart';

class QuizUpdate extends StatefulWidget {
  final String quizId;
  final Map<String, dynamic> quizData;

  QuizUpdate({required this.quizId, required this.quizData});

  @override
  _QuizUpdateState createState() => _QuizUpdateState();
}

class _QuizUpdateState extends State<QuizUpdate> {
  final DatabaseService databaseService = DatabaseService();
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.quizData['quizTitle']);
    _descController = TextEditingController(text: widget.quizData['quizDesc']);
  }

  void updateQuiz() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> updatedData = {
        "quizTitle": _titleController.text,
        "quizDesc": _descController.text,
      };

      await databaseService.updateQuizData(updatedData, widget.quizId);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Quiz'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Quiz Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quiz title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Quiz Description'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a quiz description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
             GestureDetector(
                onTap: updateQuiz,
                 child: customOrangeButton(context, 'Update',width: 200)),
            ],
          ),
        ),
      ),
    );
  }
}
