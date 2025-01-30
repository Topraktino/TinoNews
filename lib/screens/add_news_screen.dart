import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/news_provider.dart';

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
        SnackBar(
          content: Text(
            Provider.of<NewsProvider>(context, listen: false).currentLanguage ==
                    'tr'
                ? 'Lütfen tüm alanları doldurun!'
                : 'Please fill in all fields!',
          ),
        ),
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
      SnackBar(
        content: Text(
          Provider.of<NewsProvider>(context, listen: false).currentLanguage ==
                  'tr'
              ? 'Haber başarıyla eklendi!'
              : 'News added successfully!',
        ),
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      Navigator.pop(context, true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          Provider.of<NewsProvider>(context, listen: false).currentLanguage ==
                  'tr'
              ? 'Haber Ekle'
              : 'Add News',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: Provider.of<NewsProvider>(context, listen: false)
                              .currentLanguage ==
                          'tr'
                      ? "Başlık"
                      : "Title",
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(
                  labelText: Provider.of<NewsProvider>(context, listen: false)
                              .currentLanguage ==
                          'tr'
                      ? 'Açıklama'
                      : 'Description',
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _detailsController,
                decoration: InputDecoration(
                  labelText: Provider.of<NewsProvider>(context, listen: false)
                              .currentLanguage ==
                          'tr'
                      ? 'Detaylar'
                      : 'Details',
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _imageUrlController,
                decoration: InputDecoration(
                  labelText: Provider.of<NewsProvider>(context, listen: false)
                              .currentLanguage ==
                          'tr'
                      ? "Resim URL'si"
                      : "Image URL",
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _saveNews,
                  child: Text(
                    Provider.of<NewsProvider>(context, listen: false)
                                .currentLanguage ==
                            'tr'
                        ? 'OK'
                        : 'OK',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
