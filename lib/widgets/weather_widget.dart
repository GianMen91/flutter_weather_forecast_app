import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/widgets/today_forecast_widget.dart';
import '../models/weather.dart';
import 'next_days_forecasts_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.listOfWeatherForecast, required this.cityName});

  final List<Weather> listOfWeatherForecast;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [

                const Icon(Icons.location_on),
                Text(
                  cityName.toUpperCase(),
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ],
            ),
            // Next Days Forecast - Display horizontally in a row

            const SizedBox(height: 20),
            // Today Forecast
            Center(child: TodayForecastWidget(listOfWeatherForecast: listOfWeatherForecast)),

            const SizedBox(height: 20),

            // Next Days Forecast - Display horizontally in a row
            const Text(
              'Next Days Forecast',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  listOfWeatherForecast.length - 1,
                  (index) => NextDaysForecastWidget(
                    listOfWeatherForecast: listOfWeatherForecast[index + 1],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
