import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_forecast_app/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<List<Weather>> fetchWeatherForecast(String cityName) async {
    const String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
    const String apiKey = '2490e19bf3443658945b392efebeae7c';

    final String url =
        '$baseUrl/?appid=$apiKey&q=$cityName&exclude=hourly,daily&units=metric';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final jsonData = jsonDecode(response.body);
        final weatherList = jsonData['list'];

        if (weatherList is List && weatherList.isNotEmpty) {
          return _processWeatherData(jsonData);
        } else {
          throw Exception('No weather data available for this city.');
        }
      } else {
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      rethrow;
    }
  }

  List<Weather> _processWeatherData(dynamic jsonData) {
    Map<String, List<Map<String, dynamic>>> groupedData =
        _groupDataByDate(jsonData);

    return _convertToWeatherObjects(groupedData);
  }

  Map<String, List<Map<String, dynamic>>> _groupDataByDate(dynamic jsonData) {
    Map<String, List<Map<String, dynamic>>> groupedForecasts = {};

    for (var item in jsonData['list']) {
      String date = item['dt_txt'].substring(0, 10);

      groupedForecasts.putIfAbsent(date, () => []).add(item);
    }

    return groupedForecasts;
  }

  List<Weather> _convertToWeatherObjects(
      Map<String, List<Map<String, dynamic>>> groupedData) {
    List<Weather> averagedForecasts = [];

    groupedData.forEach((date, forecasts) {
      double avgTemp = _calculateAverage(forecasts, 'main', 'temp');
      double avgHumidity = _calculateAverage(forecasts, 'main', 'humidity');
      double avgWind = _calculateAverage(forecasts, 'wind', 'speed');
      double avgPressure = _calculateAverage(forecasts, 'main', 'pressure');
      double avgCloudiness = _calculateAverage(forecasts, 'clouds', 'all');

      double minTemp = forecasts
          .map((f) => f['main']['temp_min'] as num)
          .reduce((a, b) => a < b ? a : b)
          .toDouble();

      double maxTemp = forecasts
          .map((f) => f['main']['temp_max'] as num)
          .reduce((a, b) => a > b ? a : b)
          .toDouble();

      WeatherCondition avgWeatherCondition = findMostFrequentCondition(
          forecasts.map((f) => f['weather'][0]['main'] as String).toList());

      averagedForecasts.add(Weather(
        date: date,
        temperature: avgTemp,
        tempMin: minTemp,
        tempMax: maxTemp,
        humidity: avgHumidity,
        wind: avgWind,
        pressure: avgPressure,
        cloudiness: avgCloudiness,
        weatherCondition: avgWeatherCondition,
      ));
    });

    return averagedForecasts;
  }

  double _calculateAverage(
      List<Map<String, dynamic>> forecasts, String category, String key) {
    num total =
        forecasts.map((f) => f[category][key] as num).reduce((a, b) => a + b);
    return total / forecasts.length;
  }

  WeatherCondition findMostFrequentCondition(List<String> conditions) {
    // Create a map to count occurrences of each WeatherCondition
    Map<WeatherCondition, int> conditionCounts = {};

    // Populate the conditionCounts map with counts of each condition
    for (var condition in conditions) {
      WeatherCondition parsedCondition = _parseWeatherCondition(condition);

      // Check if parsedCondition already exists in conditionCounts
      if (conditionCounts.containsKey(parsedCondition)) {
        // Increment the count for parsedCondition
        conditionCounts[parsedCondition] = conditionCounts[parsedCondition]! + 1;
      } else {
        // Initialize the count for parsedCondition
        conditionCounts[parsedCondition] = 1;
      }
    }

    // Convert the map entries to a list and sort it based on count and condition index
    List<MapEntry<WeatherCondition, int>> sortedConditionEntries =
    conditionCounts.entries.toList()
      ..sort((a, b) {
        // Sort by count descending, then by condition index ascending
        int compareCount = b.value.compareTo(a.value);
        if (compareCount == 0) {
          return a.key.index.compareTo(b.key.index);
        }
        return compareCount;
      });

    // Return the WeatherCondition with the highest count (first in the sorted list)
    return sortedConditionEntries.first.key;
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
}
