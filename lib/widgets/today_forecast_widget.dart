import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_animation_widget.dart';
import 'package:intl/intl.dart';
import '../models/weather.dart';

class TodayForecastWidget extends StatelessWidget {
  const TodayForecastWidget({
    super.key,
    required this.listOfWeatherForecast,
  });

  // List of weather forecast data to display.
  final List<Weather> listOfWeatherForecast;

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen.
    final Size size = MediaQuery.of(context).size;
    // Determine if the device is in portrait mode.
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            // Display the temperature
            Text(
              '${listOfWeatherForecast[0].temperature.toInt()}°',
              style: TextStyle(
                fontSize: size.width > 600 && isPortrait ? 85 : 70,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              key: const Key('temperature_text'), // Key for testing
            ),
            const SizedBox(width: 40),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Display the day of the week
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('EEEE')
                        .format(DateTime.parse(listOfWeatherForecast[0].date)),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: size.width > 600 && isPortrait ? 35 : 26,
                    ),
                    key: const Key('day_of_week_text'), // Key for testing
                  ),
                ),
                // Display the weather condition
                Container(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    listOfWeatherForecast[0].weatherCondition.name,
                    style: TextStyle(
                      fontSize: size.width > 600 && isPortrait ? 30 : 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                    key: const Key('weather_condition_text'), // Key for testing
                  ),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 30),
        // Display the weather animation based on the condition
        SizedBox(
          width: size.width > 600 && isPortrait ? 400 : 200,
          child: Center(
            child: WeatherAnimationWidget(
                weatherConditionName: listOfWeatherForecast[0].weatherCondition.name,
                key: const Key('weather_animation_widget')), // Key for testing
          ),
        ),
        const SizedBox(height: 30),
        Column(
          children: [
            // Display humidity
            Container(
              alignment: Alignment.centerLeft,
              key: const Key('humidity_text'),
              child: Text(
                'Humidity: ${listOfWeatherForecast[0].humidity.toInt()} %',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width > 600 && isPortrait ? 25 : 15),
              ), // Key for testing
            ),
            // Display pressure
            Container(
              alignment: Alignment.centerLeft,
              key: const Key('pressure_text'),
              child: Text(
                'Pressure: ${listOfWeatherForecast[0].pressure.toInt()} hPa',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width > 600 && isPortrait ? 25 : 15),
              ), // Key for testing
            ),
            // Display wind speed
            Container(
              alignment: Alignment.centerLeft,
              key: const Key('wind_text'),
              child: Text(
                'Wind: ${listOfWeatherForecast[0].wind.toInt()} Km/h',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: size.width > 600 && isPortrait ? 25 : 15),
              ), // Key for testing
            ),
          ],
        ),
      ],
    );
  }
}
