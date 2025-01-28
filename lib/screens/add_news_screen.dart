import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'home_screen.dart';

class NewsProvider with ChangeNotifier {
  final List<Map<String, String>> _newsList = [];

  List<Map<String, String>> get newsList => _newsList;

  void addNews(
      String title, String description, String details, String imageUrl) {
    _newsList.add({
      'title': title,
      'description': description,
      'details': details,
      'imageUrl': imageUrl,
    });
    notifyListeners();
  }
}

class AddNewsScreen extends StatefulWidget {
  const AddNewsScreen({super.key});

  @override
  State<AddNewsScreen> createState() => _AddNewsScreenState();
}

class _AddNewsScreenState extends State<AddNewsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  void _saveNews() {
    if (_titleController.text.isEmpty ||
        _descriptionController.text.isEmpty ||
        _detailsController.text.isEmpty ||
        _imageUrlController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Lütfen tüm alanları doldurun!')),
      );
      return;
    }

    Provider.of<NewsProvider>(context, listen: false).addNews(
      _titleController.text,
      _descriptionController.text,
      _detailsController.text,
      _imageUrlController.text,
    );

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Haber başarıyla eklendi!')),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Haber Ekle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: "Başlık"),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Açıklama'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailsController,
                decoration: const InputDecoration(labelText: 'Detaylar'),
                maxLines: 5,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: "Resim URL'si"),
              ),
              const SizedBox(height: 20),
              _imageUrlController.text.isEmpty
                  ? const Text('Henüz URL girilmedi.')
                  : Image.network(
                      _imageUrlController.text,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Text('Geçersiz URL veya resim yüklenemedi.'),
                    ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveNews,
                  child: const Text('OK'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Ana ekranda yeni haberlerin listelenmesini sağlayan kod
class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsProvider>(
      builder: (context, newsProvider, child) {
        return ListView.builder(
          itemCount: newsProvider.newsList.length,
          itemBuilder: (context, index) {
            final news = newsProvider.newsList[index];
            return GestureDetector(
              child: NewsCard(
                title: news['title'] ?? '',
                description: news['description'] ?? '',
                imagePath: news['imageUrl'] ?? '',
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NewsDetail(
                      news['title'] ?? '',
                      news['details'] ?? '',
                      news['imageUrl'] ?? '',
                    ),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
