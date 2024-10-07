import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_forecast_app/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<List<Weather>> loadWeatherForecast(String cityName) async {
    const String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
    const String apiKey = '2490e19bf3443658945b392efebeae7c';

    final String url = '$baseUrl/?appid=$apiKey&q=$cityName&exclude=hourly,daily&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Parse the response body into a JSON object
        final jsonData = jsonDecode(response.body);
        final weatherList = jsonData['list'];

        // Check if 'list' is a valid list and contains elements
        if (weatherList is List && weatherList.isNotEmpty) {
          return decodeAverageForecast(jsonData);
        } else {
          throw Exception('No weather data available for this city.');
        }
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    }on Exception catch (e) {
      // Log the error in debug mode
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      // Rethrow the exception to be caught in the BLoC
      rethrow;
    }
  }

  List<Weather> decodeAverageForecast(jsonData) {
    Map<String, List<Weather>> groupedForecasts = {};

    for (var item in jsonData['list']) {
      String date = item['dt_txt'].substring(0, 10);
      Weather forecast = Weather(
          date: date,
          temperature: (item['main']['temp'] as num).toDouble(),
          tempMin: (item['main']['temp_min'] as num).toDouble(),
          tempMax: (item['main']['temp_max'] as num).toDouble(),
          humidity: (item['main']['humidity'] as num).toDouble(),
          wind: (item['wind']['speed'] as num).toDouble(),
          pressure: (item['main']['pressure'] as num).toDouble(),
          cloudiness: (item['clouds']['all'] as num).toDouble(),
          weatherCondition:
              _parseWeatherCondition(item['weather'][0]['main']));

      if (!groupedForecasts.containsKey(date)) {
        groupedForecasts[date] = [];
      }
      groupedForecasts[date]!.add(forecast);
    }

    List<Weather> averagedForecasts = [];
    groupedForecasts.forEach((date, forecasts) {
      double avgTemp =
          forecasts.map((f) => f.temperature).reduce((a, b) => a + b) /
              forecasts.length;
      double avgTempMin =
          forecasts.map((f) => f.tempMin).reduce((a, b) => a + b) /
              forecasts.length;
      double avgTempMax =
          forecasts.map((f) => f.tempMax).reduce((a, b) => a + b) /
              forecasts.length;
      double avgHumidity =
          forecasts.map((f) => f.humidity).reduce((a, b) => a + b) /
              forecasts.length;
      double avgWind =
          forecasts.map((f) => f.wind).reduce((a, b) => a + b) /
              forecasts.length;
      double avgPressure =
          forecasts.map((f) => f.pressure).reduce((a, b) => a + b) /
              forecasts.length;
      double avgCloudiness =
          forecasts.map((f) => f.cloudiness).reduce((a, b) => a + b) /
              forecasts.length;
      WeatherCondition avgWeatherCondition =
          _determineMostFrequentCondition(forecasts);

      averagedForecasts.add(Weather(
        date: date,
        temperature: avgTemp,
        tempMin: avgTempMin,
        tempMax: avgTempMax,
        humidity: avgHumidity,
        wind: avgWind,
        pressure: avgPressure,
        cloudiness: avgCloudiness,
        weatherCondition: avgWeatherCondition,
      ));
    });
    return averagedForecasts;
  }

  WeatherCondition _parseWeatherCondition(String condition) {
    switch (condition.toLowerCase()) {
      case 'clear':
        return WeatherCondition.sun;
      case 'clouds':
        return WeatherCondition.cloud;
      case 'rain':
        return WeatherCondition.rain;
      case 'snow':
        return WeatherCondition.snow;
      default:
        return WeatherCondition.partiallyCloudy;
    }
  }

  WeatherCondition _determineMostFrequentCondition(
      List<Weather> forecasts) {
    var conditionCounts = SplayTreeMap<WeatherCondition, int>(
        (a, b) => b.index.compareTo(a.index));
    for (var forecast in forecasts) {
      conditionCounts.update(forecast.weatherCondition, (value) => value + 1,
          ifAbsent: () => 1);
    }

    var sortedCondition = conditionCounts.entries.toList()
      ..sort((a, b) {
        int compareCount = b.value.compareTo((a.value));
        if (compareCount == 0) {
          return a.key.index.compareTo(b.key.index);
        }
        return compareCount;
      });
    return sortedCondition.first.key;
  }
}
