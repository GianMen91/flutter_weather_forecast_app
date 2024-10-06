class WeatherForecast {
  final String date;
  final double temperature;
  final double humidity;
  final double wind;
  final double pressure;
  final double cloudiness;
  final WeatherCondition weatherCondition;

  WeatherForecast({
    required this.date,
    required this.temperature,
    required this.humidity,
    required this.wind,
    required this.pressure,
    required this.cloudiness,
    required this.weatherCondition,
  });

  factory WeatherForecast.fromJson(Map<String, dynamic> json) {
    return WeatherForecast(
      date: json['date'] as String,
      temperature: (json['temperature'] as num).toDouble(),
      humidity: (json['humidity'] as num).toDouble(),
      wind: (json['wind'] as num).toDouble(),
      pressure: (json['pressure'] as num).toDouble(),
      cloudiness: (json['cloudiness'] as num).toDouble(),
      weatherCondition: _mapStringToWeatherCondition(json['weatherCondition'] as String),
    );
  }

  static WeatherCondition _mapStringToWeatherCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'sun':
        return WeatherCondition.sun;
      case 'cloud':
        return WeatherCondition.cloud;
      case 'rain':
        return WeatherCondition.rain;
      case 'partiallyCloudy':
        return WeatherCondition.partiallyCloudy;
      case 'snow':
        return WeatherCondition.snow;
      default:
        throw ArgumentError('Invalid weather condition: $condition');
    }
  }

  @override
  String toString() {
    return 'WeatherForecast{date: $date, temperature: $temperature, humidity: $humidity, wind: $wind, pressure: $pressure, cloudiness: $cloudiness, weatherCondition: $weatherCondition}';
  }
}

enum WeatherCondition { sun, cloud, rain, partiallyCloudy, snow }
