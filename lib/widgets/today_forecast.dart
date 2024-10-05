import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
        SizedBox(height: 10),
        Text('Tuesday', style:TextStyle(fontSize: 25, fontWeight: FontWeight.bold,color: Colors.black)),
        SizedBox(height: 10),
        Card(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(Icons.sunny, size: 100),
                Text(listOfWeatherForecast[0] .date),
                Text('Temperatyre:${listOfWeatherForecast[0].temperature}'),
              ],
            )),
        SizedBox(height: 10),
      ],
    );
  }
}