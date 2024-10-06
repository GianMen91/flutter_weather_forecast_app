import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_image_widget.dart';
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
        Row(
          children: [
            Text(
              '${listOfWeatherForecast[0].temperature.toInt()}°',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligns children to the start
              children: [
                Container(
                  alignment: Alignment.centerLeft, // Align to left
                  child: Text(
                    DateFormat('EEEE')
                        .format(DateTime.parse(listOfWeatherForecast[0].date)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft, // Align to left
                  child: Text(
                    listOfWeatherForecast[0].weatherCondition.name,
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        // Placeholder for weather icon (can use network image or custom icon)
        SizedBox(
          width: 200,
          child: Center(
            child: WeatherImageWidget(weatherConditionName: listOfWeatherForecast[0].weatherCondition.name),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text(
                    'Humidity: ${listOfWeatherForecast[0].humidity.toInt()} %',
                    style: const TextStyle(color: Colors.white, fontSize: 15))),
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text(
                    'Pressure: ${listOfWeatherForecast[0].pressure.toInt()} hPa',
                    style: const TextStyle(color: Colors.white, fontSize: 15))),
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text('Wind: ${listOfWeatherForecast[0].wind.toInt()} Km/h',
                    style: const TextStyle(color: Colors.white, fontSize: 15))),
          ],
        ),
      ],
    );
  }
}
