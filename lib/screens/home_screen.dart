import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'news_provider.dart';
import 'add_news_screen.dart';
import 'news_detail.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const NewsPage();
  }
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  bool darkMode = false;

  // Dil seçeneği (Türkçe varsayılan)
  String currentLanguage = 'tr';

  // Dil Kaynakları
  final Map<String, Map<String, String>> localizedStrings = {
    'tr': {
      'title': 'Haberler',
      'darkMode': 'Karanlık Mod',
      'lightMode': 'Aydınlık Mod',
      'addNews': 'Haber Ekle',
      'noNews': 'Henüz haber eklenmedi.',
      'imageError': 'Resim yüklenemedi',
    },
    'en': {
      'title': 'News',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'addNews': 'Add News',
      'noNews': 'No news added yet.',
      'imageError': 'Image could not be loaded',
    },
  };

  String translate(String key) {
    return localizedStrings[currentLanguage]?[key] ?? key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(translate('title')),
        backgroundColor: darkMode ? Colors.black : Colors.blue,
        actions: [
          IconButton(
            icon: Icon(darkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              setState(() {
                darkMode = !darkMode;
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.language),
            onPressed: () {
              setState(() {
                currentLanguage = currentLanguage == 'tr' ? 'en' : 'tr';
              });
            },
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddNewsScreen()),
              );

              if (result == true) {
                setState(() {}); // Ekranı yenile
              }
            },
          ),
        ],
      ),
      body: Consumer<NewsProvider>(
        builder: (context, newsProvider, child) {
          return newsProvider.newsList.isEmpty
              ? Center(child: Text(translate('noNews')))
              : ListView.builder(
                  itemCount: newsProvider.newsList.length,
                  itemBuilder: (context, index) {
                    final news = newsProvider.newsList[index];
                    return GestureDetector(
                      child: NewsCard(
                        title: news['title'] ?? '',
                        description: news['description'] ?? '',
                        imagePath: news['imageUrl'] ?? '',
                        translate: translate,
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
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final String Function(String) translate;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.translate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            imagePath,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
            errorBuilder: (context, error, stackTrace) =>
                Text(translate('imageError')),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  description,
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
