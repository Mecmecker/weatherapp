import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:weatherapp/models/models.dart';
import 'package:http/http.dart' as http;

class CurrentWeatherProvider extends ChangeNotifier {
  final String _apiKey = dotenv.env['API_KEY']!;
  final String _baseUrl = 'pro.openweathermap.org';
  final String _language = 'es';
  final String _units = 'metric';
  final String _city = 'Valencia';

  //Para pruebas, Luego se leeran de los favoritos guardados
  final List<String> _cities = ['Barcelona', 'Madrid', 'Valencia'];

  List<CurrentWeather> currentWeathers = [];

  CurrentWeatherProvider() {
    getCurrentWeatherByCity(_city);
    for (var city in _cities) {
      getCurrentWeatherByCity(city);
    }
  }

  Future<String> _getJsonData(String endpoint, String city) async {
    final url = Uri.https(_baseUrl, endpoint,
        {'q': city, 'APPID': _apiKey, 'lang': _language, 'units': _units});
    final response = await http.get(url);
    return response.body;
  }

  getCurrentWeatherByCity(String city) async {
    final jsonData = await _getJsonData('data/2.5/weather', city);
    final CurrentWeather currentWeather = CurrentWeather.fromJson(jsonData);
    currentWeathers.add(currentWeather);

    notifyListeners();
  }
}
