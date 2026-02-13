class Question {
  final String text;
  final Map<String, String> options;
  final String answer;
  final String explain;

  Question({
    required this.text,
    required this.options,
    required this.answer,
    required this.explain,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      options: Map<String, String>.from(json['options']),
      answer: json['answer'],
      explain: json['explain'],
    );
  }
}