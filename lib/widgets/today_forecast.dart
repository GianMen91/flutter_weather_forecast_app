import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/weather_forecast.dart';

class TodayForecast extends StatelessWidget {
  const TodayForecast({
    super.key,
    required this.listOfWeatherForecast,
  });

  final List<WeatherForecast> listOfWeatherForecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 10),
        Text(
            DateFormat('EEEE').format(
              DateTime.parse(listOfWeatherForecast[0].date),
            ),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 10),
        Text(listOfWeatherForecast[0].weatherCondition.name,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            )),
        const SizedBox(height: 10),
        Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.sunny, size: 100),
            Text(
              '${listOfWeatherForecast[0].temperature.toInt()} °',
              style: const TextStyle(fontSize: 30),
            ),
            Text('Humidity:${listOfWeatherForecast[0].humidity.toInt()} %'),
            Text('Pressure:${listOfWeatherForecast[0].pressure.toInt()} hPa'),
            Text('Wind:${listOfWeatherForecast[0].wind} Km/h'),
          ],
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
