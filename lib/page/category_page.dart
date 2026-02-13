import 'package:flutter/material.dart';
import 'quiz_page.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({super.key});

  final List<Map<String, dynamic>> categories = const [
    {
      "name": "Agama Islam",
      "desc": "Pendidikan Agama dan Budi Pekerti",
      "icon": Icons.menu_book_outlined,
      "color": Color(0xFF4CAF50),
    },
    {
      "name": "Bahasa Indonesia",
      "desc": "Kemampuan berbahasa dan sastra",
      "icon": Icons.library_books,
      "color": Color(0xFF2196F3),
    },
    {
      "name": "Matematika",
      "desc": "Logika dan perhitungan",
      "icon": Icons.calculate,
      "color": Color(0xFFFF9800),
    },
    {
      "name": "IPA",
      "desc": "Ilmu Pengetahuan Alam",
      "icon": Icons.science,
      "color": Color(0xFF9C27B0),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kategori Kuis')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final c = categories[index];
          return Card(
            color: c['color'],
            child: ListTile(
              leading: Icon(c['icon'], color: Colors.white),
              title: Text(
                c['name'],
                style: const TextStyle(color: Colors.white),
              ),
              subtitle: Text(
                c['desc'],
                style: const TextStyle(color: Colors.white70),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => QuizPage(category: c['name']),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}