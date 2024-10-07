import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/widgets/today_forecast_widget.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../models/weather.dart';
import 'next_days_forecasts_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(
      {super.key, required this.listOfWeatherForecast, required this.cityName});

  final List<Weather> listOfWeatherForecast;
  final String cityName;

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
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
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 24),
                    const SizedBox(width: 10),
                    Text(
                      cityName.toUpperCase(),
                      style: const TextStyle(
                        fontSize: 24,
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
                    size: 24,
                  ),
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(ClearWeatherForecastEvent());
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
              'Weekly Weather Forecast',
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(height: 40),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  listOfWeatherForecast.length,
                  (index) => NextDaysForecastWidget(
                    weatherForecast: listOfWeatherForecast[index],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    )));
  }
}
