import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import '../models/forecast_model.dart';
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey = 'e87c411941a0cb2822abe0262b5e79e6';

  Future<Weather> fetchWeather(double lat,double long) async {
    final response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$long&appid=$apiKey&units=metric'));
    if (response.statusCode == 200) {
      return Weather.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather');
    }
  }

  Future<List<WeatherForecast>> fetchForecast(double lat, double lon) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$apiKey&units=metric'));

    if (response.statusCode == 200) {
      List<dynamic> forecastList = json.decode(response.body)['list'];
      return forecastList
          .map((forecast) => WeatherForecast.fromJson(forecast))
          .toList();
    } else {
      throw Exception('Failed to load forecast');
    }
  }



}