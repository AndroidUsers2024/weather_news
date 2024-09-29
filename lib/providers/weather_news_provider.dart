import 'package:flutter/material.dart';
import 'package:weather_news/models/news_model.dart';
import 'package:weather_news/providers/settings_model.dart';
import 'package:weather_news/services/news_service.dart';
import '../models/forecast_model.dart';
import '../models/weather_model.dart';
import '../services/location_service.dart';
import '../services/weather_service.dart';


class WeatherNewsProvider with ChangeNotifier {
  Weather? _weather;
  List<News>? _news;
  bool isCelsius = true;

  Weather? get weather => _weather;
  List<News>? get news => _news;
  final LocationService _locationService = LocationService();
  List<WeatherForecast> _forecast = [];
  List<WeatherForecast> get forecast => _forecast;
  WeatherService weatherService = WeatherService();
  NewsService newsService = NewsService();

  String filterNews(double temperature) {
    if (temperature < 10) {
      // Cold weather
      return "sadness OR depression";
    } else if (temperature > 25) {
      // Hot weather
      return "fear";
    } else {
      // Cool weather
      return "happiness OR winning";
    }
  }

  String toForenheit(double val){
    String res ="0";
    try{
      res = ((val * 9 / 5) + 32).toStringAsFixed(2);
    }catch(e){
      print("Exception: toForenheit(): "+e.toString());
    }

    return "${res}°F";
  }


  Future<void> fetchWeather() async {
    final position = await _locationService.getCurrentLocation();
    double lat=position.latitude;
    double lon=position.longitude;
    _weather = await weatherService.fetchWeather(lat, lon);
    _forecast = await weatherService.fetchForecast(lat, lon);

    String queryForNews = filterNews(_weather!.temperature);

    if (_weather != null) {
      _news = await newsService.fetchNews(queryForNews);
    }
    notifyListeners();
  }
}
