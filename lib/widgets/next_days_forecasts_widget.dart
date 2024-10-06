import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';

class NextDaysForecastWidget extends StatelessWidget {
  const NextDaysForecastWidget({
    super.key,
    required this.listOfWeatherForecast,
  });

  final Weather listOfWeatherForecast;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            DateFormat('EEE')
                .format(DateTime.parse(listOfWeatherForecast.date)),
            style: const TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          const Icon(Icons.sunny, size: 40),
          const SizedBox(height: 10),
          Text(
              '${listOfWeatherForecast.tempMin.toInt()}° / ${listOfWeatherForecast.tempMax.toInt()}°'),
        ],
      ),
    );
  }
}
