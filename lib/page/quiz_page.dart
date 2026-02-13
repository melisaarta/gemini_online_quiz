import 'package:flutter/material.dart';
import '../model/model_question.dart';
import '../services/quiz_service.dart';
import 'result_page.dart';

class QuizPage extends StatefulWidget {
  final String category;
  const QuizPage({super.key, required this.category});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final QuizService _service =
      QuizService(apiKey: 'GEMINI_API_KEY');
  final List<String> levels = ['Easy', 'Medium', 'Hard'];

  List<Question> questions = [];
  Map<int, String> answers = {};
  bool loading = false;
  String? selectedLevel;

  void loadQuestions() async {
    setState(() => loading = true);
    questions = await _service.fetchQuestions(
      context,
      widget.category,
      selectedLevel!,
    );
    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.category)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : questions.isEmpty
                ? Column(
                    children: [
                      DropdownButton<String>(
                        hint: const Text('Pilih Level'),
                        value: selectedLevel,
                        items: levels
                            .map((e) =>
                                DropdownMenuItem(value: e, child: Text(e)))
                            .toList(),
                        onChanged: (v) => setState(() => selectedLevel = v),
                      ),
                      ElevatedButton(
                        onPressed:
                            selectedLevel == null ? null : loadQuestions,
                        child: const Text('Mulai Kuis'),
                      ),
                    ],
                  )
                : ListView(
                    children: [
                      ...questions.asMap().entries.map((entry) {
                        final i = entry.key;
                        final q = entry.value;
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${i + 1}. ${q.text}'),
                                ...q.options.entries.map(
                                  (opt) => RadioListTile<String>(
                                    value: opt.key,
                                    groupValue: answers[i],
                                    title:
                                        Text('${opt.key}. ${opt.value}'),
                                    onChanged: (v) {
                                      setState(() => answers[i] = v!);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                      ElevatedButton(
                        onPressed: () {
                          int score = 0;
                          for (int i = 0; i < questions.length; i++) {
                            if (answers[i] == questions[i].answer) {
                              score++;
                            }
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResultPage(
                                questions: questions,
                                answers: answers,
                                score: score,
                              ),
                            ),
                          );
                        },
                        child: const Text('Submit'),
                      )
                    ],
                  ),
      ),
    );
  }
}