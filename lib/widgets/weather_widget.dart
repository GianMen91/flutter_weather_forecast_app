import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/widgets/today_forecast_widget.dart';
import '../models/weather.dart';
import 'next_days_forecasts_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(
      {super.key, required this.listOfWeatherForecast, required this.cityName});

  final List<Weather> listOfWeatherForecast;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Center(
            // Use Center to center the SingleChildScrollView
            child: SingleChildScrollView(
      child: ConstrainedBox(
        // Use ConstrainedBox to limit the width of the child elements
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.8, // Set max width to 80% of the screen width
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      cityName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // Handle back button press
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
                child: TodayForecastWidget(
                    listOfWeatherForecast: listOfWeatherForecast)),
            const SizedBox(height: 20),

            // Next Days Forecast - Display horizontally in a row
            const Text(
              'Next Days Forecast',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 20),
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
    )));
  }
}
