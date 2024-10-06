import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
            Text(
                DateFormat('EEEE').format(
                  DateTime.parse(listOfWeatherForecast.date),
                ),
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                )),
            Icon(Icons.sunny, size: 30),
            Text('${listOfWeatherForecast.temp_min.toInt()} ° / ${listOfWeatherForecast.temp_max.toInt()} '),
          ],
        ));
  }
}