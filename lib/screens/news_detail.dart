import 'package:flutter/material.dart';

class NewsDetail extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const NewsDetail(this.title, this.description, this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Text('Resim yüklenemedi'),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Text(
                description,
                style: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
