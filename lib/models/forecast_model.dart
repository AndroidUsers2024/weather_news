class WeatherForecast {
  final String date;
  final String condition;
  final double temperature;

  WeatherForecast({
    required this.date,
    required this.condition,
    required this.temperature,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: json['dt_txt'],
      condition: json['weather'][0]['description'],
      temperature: (json['main']['temp'] is int)
          ? (json['main']['temp'] as int).toDouble()
          : json['main']['temp'].toDouble(),
    );
  }
}
