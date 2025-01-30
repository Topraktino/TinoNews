import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String apiKey = "YOUR_API_KEY"; // Buraya API anahtarınızı girin
  final String baseUrl = "https://api.collectapi.com/weather/getWeather";

  Future<Map<String, dynamic>> getWeather(String city) async {
    final url = Uri.parse("$baseUrl?data.lang=tr&data.city=$city");

    final response = await http.get(
      url,
      headers: {
        'authorization': 'apikey $apiKey',
        'content-type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception("Hava durumu verisi alınamadı!");
    }
  }
}
