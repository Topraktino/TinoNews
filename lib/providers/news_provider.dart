import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class NewsProvider with ChangeNotifier {
  List<Map<String, String>> _newsList = [];
  String _currentLanguage = 'tr';

  List<Map<String, String>> get newsList => _newsList;
  String get currentLanguage => _currentLanguage;

  NewsProvider() {
    loadNews();
  }

  void changeLanguage(String language) {
    _currentLanguage = language;
    notifyListeners();
  }

  bool isDesktop() {
    try {
      return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
    } catch (e) {
      return false;
    }
  }

  Future<Directory> getDocumentsDirectory() async {
    if (isDesktop()) {
      return Directory('${Directory.current.path}/news_data');
    } else {
      return await getApplicationDocumentsDirectory();
    }
  }

  Future<void> loadNews() async {
    try {
      final directory = await getDocumentsDirectory();
      final file = File('${directory.path}/news.json');

      if (!directory.existsSync()) {
        directory.createSync(recursive: true);
      }

      if (file.existsSync()) {
        String data = await file.readAsString();
        List<dynamic> jsonData = jsonDecode(data);

        _newsList = jsonData.map((e) => Map<String, String>.from(e)).toList();
        notifyListeners();
      } else {
        print("news.json dosyası bulunamadı, yeni dosya oluşturuluyor...");
        await saveNews();
      }
    } catch (e) {
      print("Haberleri yüklerken hata oluştu: $e");
    }
  }

  Future<void> saveNews() async {
    try {
      final directory = await getDocumentsDirectory();
      final file = File('${directory.path}/news.json');
      await file.writeAsString(jsonEncode(_newsList));
      print("news.json başarıyla kaydedildi.");
    } catch (e) {
      print("Haberleri kaydederken hata oluştu: $e");
    }
  }

  void addNews(
      String title, String description, String details, String imageUrl) async {
    _newsList.add({
      'title': title,
      'description': description,
      'details': details,
      'imageUrl': imageUrl,
    });

    await saveNews();
    notifyListeners();
  }
}
