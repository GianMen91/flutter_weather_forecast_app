import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_animation_widget.dart';
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

    final Size size = MediaQuery.of(context).size;

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              '${listOfWeatherForecast[0].temperature.toInt()}°',
              style:  TextStyle(
                fontSize: size.width > 600 ? 85 : 70,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligns children to the start
              children: [
                Container(
                  alignment: Alignment.centerLeft, // Align to left
                  child: Text(
                    DateFormat('EEEE')
                        .format(DateTime.parse(listOfWeatherForecast[0].date)),
                    style:  TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.width > 600 ? 35 : 26,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft, // Align to left
                  child: Text(
                    listOfWeatherForecast[0].weatherCondition.name,
                    style:  TextStyle(
                      fontSize: size.width > 600 ? 30 : 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 30),
        SizedBox(
          width: 400,
          child: Center(
            child: WeatherAnimationWidget(
                weatherConditionName:
                    listOfWeatherForecast[0].weatherCondition.name),
          ),
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text(
                    'Humidity: ${listOfWeatherForecast[0].humidity.toInt()} %',
                    style:  TextStyle(color: Colors.white,  fontSize: size.width > 600 ? 25 : 15))),
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text(
                    'Pressure: ${listOfWeatherForecast[0].pressure.toInt()} hPa',
                    style:  TextStyle(color: Colors.white,  fontSize: size.width > 600 ? 25 : 15))),
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text(
                    'Wind: ${listOfWeatherForecast[0].wind.toInt()} Km/h',
                    style:  TextStyle(color: Colors.white,  fontSize: size.width > 600 ? 25 : 15))),
          ],
        ),
      ],
    );
  }
}
