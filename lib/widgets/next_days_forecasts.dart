import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/weather_forecast.dart';

class NextDaysForecast extends StatelessWidget {
  const NextDaysForecast({
    super.key,
    required this.listOfWeatherForecast,
  });

  final WeatherForecast listOfWeatherForecast;

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(listOfWeatherForecast.date),
            Icon(Icons.sunny, size: 30),
            Text(listOfWeatherForecast.temperature.toString()),
          ],
        ));
  }
}