import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_weather_forecast_app/models/weather.dart';
import 'package:http/http.dart' as http;

class WeatherRepository {
  Future<List<Weather>> fetchWeatherForecast(String cityName) async {
    const String baseUrl = 'https://api.openweathermap.org/data/2.5/forecast';
    const String apiKey = '2490e19bf3443658945b392efebeae7c';

    /* The OpenWeatherMap API's forecast endpoint (/data/2.5/forecast)
       provides weather data for the next 5 days, with forecasts available
       every 3 hours. Each forecast entry contains weather data (e.g., temperature,
       humidity, etc.) for a specific time within the day. */

    // Construct the complete URL with the base URL, API key, city name, and units.
    final String url =
        '$baseUrl/?appid=$apiKey&q=$cityName&exclude=hourly,daily&units=metric';

    try {
      // Make the HTTP GET request to the API.
      final response = await http.get(Uri.parse(url));

      // Check if the request was successful.
      if (response.statusCode == 200) {
        // Decode the JSON response.
        final jsonData = jsonDecode(response.body);

        // Extract the list of forecasts from the JSON data.
        final weatherList = jsonData['list'];

        // If the response contains weather data, process and return it.
        if (weatherList is List && weatherList.isNotEmpty) {
          return _processWeatherData(jsonData);
        } else {
          // Throw an exception if no weather data is available.
          throw Exception('No weather data available for this city.');
        }
      } else {
        // Throw an exception if the request failed with a non-200 status code.
        throw Exception('Failed to load weather data: ${response.statusCode}');
      }
    } on Exception catch (e) {
      // Print error messages in debug mode.
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      // Rethrow the exception to be handled by the calling code.
      rethrow;
    }
  }

  // Processes the raw JSON data and converts it into a list of [Weather] objects.
  List<Weather> _processWeatherData(dynamic jsonData) {
    // Group the data by date to create daily weather summaries.
    Map<String, List<Map<String, dynamic>>> groupedData = _groupDataByDate(jsonData);

    // Convert the grouped data into a list of [Weather] objects.
    return _convertToWeatherObjects(groupedData);
  }

  // Groups the forecast data by date.
  // Returns a map where each key is a date (in "YYYY-MM-DD" format),
  // and each value is a list of weather data entries for that date.
  Map<String, List<Map<String, dynamic>>> _groupDataByDate(dynamic jsonData) {
    Map<String, List<Map<String, dynamic>>> groupedForecasts = {};

    // Iterate over each forecast entry in the JSON data.
    for (var item in jsonData['list']) {
      // Extract the date (first 10 characters) from the 'dt_txt' field.
      String date = item['dt_txt'].substring(0, 10);

      // Group the forecast entries by date.
      groupedForecasts.putIfAbsent(date, () => []).add(item);
    }

    return groupedForecasts;
  }

  // Converts the grouped forecast data into a list of [Weather] objects,
  // calculating the daily averages for each weather parameter.
  List<Weather> _convertToWeatherObjects(
      Map<String, List<Map<String, dynamic>>> groupedData) {
    List<Weather> averagedForecasts = [];

    // Iterate over each date and its corresponding forecasts.
    groupedData.forEach((date, forecasts) {
      // Calculate daily averages for temperature, humidity, wind, pressure, and cloudiness.
      double avgTemp = _calculateAverage(forecasts, 'main', 'temp');
      double avgHumidity = _calculateAverage(forecasts, 'main', 'humidity');
      double avgWind = _calculateAverage(forecasts, 'wind', 'speed');
      double avgPressure = _calculateAverage(forecasts, 'main', 'pressure');
      double avgCloudiness = _calculateAverage(forecasts, 'clouds', 'all');

      // Calculate the minimum and maximum temperatures for the day.
      double minTemp = forecasts
          .map((f) => f['main']['temp_min'] as num)
          .reduce((a, b) => a < b ? a : b)
          .toDouble();

      double maxTemp = forecasts
          .map((f) => f['main']['temp_max'] as num)
          .reduce((a, b) => a > b ? a : b)
          .toDouble();

      // Determine the most frequent weather condition for the day.
      WeatherCondition avgWeatherCondition = findMostFrequentCondition(
          forecasts.map((f) => f['weather'][0]['main'] as String).toList());

      // Create a new Weather object and add it to the list.
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

  // Calculates the average value of a specific key in the forecast data.
  double _calculateAverage(
      List<Map<String, dynamic>> forecasts, String category, String key) {
    // Sum up all values for the given key in the category.
    num total =
    forecasts.map((f) => f[category][key] as num).reduce((a, b) => a + b);

    // Return the average value.
    return total / forecasts.length;
  }

  // Finds the most frequently occurring weather condition in the list of conditions.
  WeatherCondition findMostFrequentCondition(List<String> conditions) {
    // Create a map to count occurrences of each WeatherCondition.
    Map<WeatherCondition, int> conditionCounts = {};

    // Populate the conditionCounts map with counts of each condition.
    for (var condition in conditions) {
      WeatherCondition parsedCondition = _parseWeatherCondition(condition);

      // If the condition is already in the map, increment its count.
      if (conditionCounts.containsKey(parsedCondition)) {
        conditionCounts[parsedCondition] = conditionCounts[parsedCondition]! + 1;
      } else {
        // Otherwise, initialize the count for the condition.
        conditionCounts[parsedCondition] = 1;
      }
    }

    // Convert the map entries to a list and sort it by count (descending) and condition index.
    List<MapEntry<WeatherCondition, int>> sortedConditionEntries =
    conditionCounts.entries.toList()
      ..sort((a, b) {
        int compareCount = b.value.compareTo(a.value);
        if (compareCount == 0) {
          // If counts are equal, sort by the WeatherCondition index (natural order).
          return a.key.index.compareTo(b.key.index);
        }
        return compareCount;
      });

    // Return the WeatherCondition with the highest count.
    return sortedConditionEntries.first.key;
  }

  // Parses a string representing a weather condition into a [WeatherCondition] enum.
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