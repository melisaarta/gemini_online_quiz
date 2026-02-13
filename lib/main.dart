import 'package:flutter/material.dart';
import 'page/category_page.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz AI',
      theme: ThemeData(
        useMaterial3: false,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CategoryPage(),
    );
  }
}