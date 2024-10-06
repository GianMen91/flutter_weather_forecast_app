import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';

class TodayForecastWidget extends StatelessWidget {
  const TodayForecastWidget({
    super.key,
    required this.listOfWeatherForecast,
  });

  final List<Weather> listOfWeatherForecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          DateFormat('EEEE')
              .format(DateTime.parse(listOfWeatherForecast[0].date)),
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          listOfWeatherForecast[0].weatherCondition.name,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 20),
        // Placeholder for weather icon (can use network image or custom icon)
        const Center(
          child: Icon(Icons.sunny, size: 100),
        ),
        const SizedBox(height: 20),
        Text(
          '${listOfWeatherForecast[0].temperature.toInt()}°',
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        Text('Humidity: ${listOfWeatherForecast[0].humidity.toInt()} %'),
        Text('Pressure: ${listOfWeatherForecast[0].pressure.toInt()} hPa'),
        Text('Wind: ${listOfWeatherForecast[0].wind} Km/h'),
      ],
    );
  }
}
