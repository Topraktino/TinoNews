import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: NewsPage(),
    );
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
      'news1_title': 'Milli takımdan galibiyet!',
      'news1_description': 'MACARİSTANI GEÇİYORUZ!',
      'news1_details':
          '92-66 Skor ile Macaristan karşısında ezici üstünlükle grubumuzdaki ilk galibiyeti alıyoruz!',
      'news2_title': 'Capybaraların nesli tehlikede!',
      'news2_description': 'Bu hayvanın nesli tükeniyor!',
      'news2_details':
          'Capybara avcılar tarafından tehdit ediliyor ve doğal alanları yok ediliyor.',
      'news3_title': 'Mete Gazoz tekrar Avrupa Şampiyonu',
      'news3_description': 'Altın madalyanın kazananı oldu.',
      'news3_details':
          'Yarı finalde Almanyayı 5-0 yenerek finale yükselen Mete Gazoz, Slovenyayı da yenerek şampiyon oldu.',
      'news4_title': 'Son Dakika!',
      'news4_description': 'Doğalgaza %80in üzerinde zam bekleniyor!!!',
      'news4_details':
          'İçişleri Bakanımız Keyvan Arasteh yaptığı son açıklamada “Doğalgaza %80 civarında zam yapacağız.” dedi',
      'news5_title': 'Fenerbahçe Avrupada mağlup oldu',
      'news5_description': 'Athletic Bilbao Takımından Çok İyi Oyun!',
      'news5_details':
          'Athletic Bilbao ile Avrupa maçına çıkan temsilcimiz Fenerbahçe, ne yazık ki 2-0 gibi üzücü bir skorla mağlup oldu. GOLLER Dakika 1 - Inaki Williams, Dakika 53 - Inaki Williams',
    },
    'en': {
      'title': 'News',
      'darkMode': 'Dark Mode',
      'lightMode': 'Light Mode',
      'news1_title': 'National team victory!',
      'news1_description': 'WE DEFEATED HUNGARY!',
      'news1_details':
          'With a score of 92-66, we secured our first group win against Hungary!',
      'news2_title': 'Capybaras are endangered!',
      'news2_description': 'This animal is on the brink of extinction!',
      'news2_details':
          'Capybaras are threatened by hunters and destruction of their habitats.',
      'news3_title': 'Mete Gazoz is European Champion again',
      'news3_description': 'Won the gold medal.',
      'news3_details':
          'After beating Germany 5-0 in the semi-finals, Mete Gazoz also won the final against Slovenia!',
      'news4_title': 'Breaking News!',
      'news4_description': 'Over 80% hike expected!!!',
      'news4_details':
          'Our Interior Minister Keyvan Arasteh said in his latest statement, “We will increase natural gas by around 80%.”',
      'news5_title': 'Fenerbahçe defeated in Europe',
      'news5_description': 'Very Good Game by Athletic Bilbao!',
      'news5_details':
          'Our representative Fenerbahçe, who played a European match against Athletic Bilbao, unfortunately lost with a sad score of 2-0. Goals minute 1 - Inaki Williams, minute 53 - Inaki Williams',
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
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10), // Üst boşluk
          Expanded(
            child: Container(
              color: darkMode ? Colors.black : Colors.white,
              child: ListView(
                children: [
                  GestureDetector(
                    child: NewsCard(
                      title: translate('news1_title'),
                      description: translate('news1_description'),
                      imagePath: 'assets/images/haber1.jpg',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            translate('news1_title'),
                            translate('news1_details'),
                            'assets/images/haber1.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: NewsCard(
                      title: translate('news2_title'),
                      description: translate('news2_description'),
                      imagePath: 'assets/images/haber2.jpg',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            translate('news2_title'),
                            translate('news2_details'),
                            'assets/images/haber2.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: NewsCard(
                      title: translate('news4_title'),
                      description: translate('news4_description'),
                      imagePath: 'assets/images/sondakika.jpg',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            translate('news4_title'),
                            translate('news4_details'),
                            'assets/images/sondakika.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    child: NewsCard(
                      title: translate('news5_title'),
                      description: translate('news5_description'),
                      imagePath: 'assets/images/fbbilbao.jpg',
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            translate('news5_title'),
                            translate('news5_details'),
                            'assets/images/fbbilbao.jpg',
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetail(
                            translate('news3_title'),
                            translate('news3_details'),
                            'assets/images/haber3.jpg',
                          ),
                        ),
                      );
                    },
                    child: NewsCard(
                      title: translate('news3_title'),
                      description: translate('news3_description'),
                      imagePath: 'assets/images/haber3.jpg',
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 10), // Alt ve üst boşluk
            child: Text(
              "Toprak Egemen Coşkun tarafından geliştirilmiştir.",
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class NewsCard extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const NewsCard({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            height: 150,
            width: double.infinity,
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
            Image.asset(
              imagePath,
              width: double.infinity,
              fit: BoxFit.cover,
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
