import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/model_question.dart';

class QuizService {
  final String apiKey;

  QuizService({required this.apiKey});

  Future<List<Question>> fetchQuestions(
    BuildContext context,
    String category,
    String level,
  ) async {
    final url =
        'https://generativelanguage.googleapis.com/v1/models/gemini-2.5-flash:generateContent?key=$apiKey';

    final prompt = '''
Buatkan 5 soal kuis kategori $category level $level dalam format JSON.
Struktur WAJIB seperti berikut:

[
  {
    "text": "Pertanyaan",
    "options": {
      "A": "Pilihan A",
      "B": "Pilihan B",
      "C": "Pilihan C",
      "D": "Pilihan D"
    },
    "answer": "A",
    "explain": "Penjelasan singkat"
  }
]
''';

    final body = {
      "contents": [
        {
          "role": "user",
          "parts": [
            {"text": prompt}
          ]
        }
      ]
    };

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final text =
            data['candidates'][0]['content']['parts'][0]['text'];

        final cleanText = text
            .replaceAll(RegExp(r'```json'), '')
            .replaceAll(RegExp(r'```'), '')
            .trim();

        final jsonList = jsonDecode(cleanText) as List;
        return jsonList.map((e) => Question.fromJson(e)).toList();
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat soal: $e')),
      );
    }

    return [];
  }
}