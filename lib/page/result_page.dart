import 'package:flutter/material.dart';
import '../model/model_question.dart';

class ResultPage extends StatelessWidget {
  final List<Question> questions;
  final Map<int, String> answers;
  final int score;

  const ResultPage({
    super.key,
    required this.questions,
    required this.answers,
    required this.score,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hasil Kuis')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Skor kamu: $score / ${questions.length}',
            style: const TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 16),
          ...questions.asMap().entries.map((e) {
            final i = e.key;
            final q = e.value;
            final isCorrect = answers[i] == q.answer;
            return Card(
              color: isCorrect ? Colors.green[50] : Colors.red[50],
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(q.text),
                    Text('Jawaban kamu: ${answers[i] ?? '-'}'),
                    Text('Jawaban benar: ${q.answer}'),
                    Text('Pembahasan: ${q.explain}'),
                  ],
                ),
              ),
            );
          }),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Kembali'),
          )
        ],
      ),
    );
  }
}