import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_animation_widget.dart';
import 'package:intl/intl.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../models/weather.dart';

class NextDaysForecastWidget extends StatelessWidget {
  const NextDaysForecastWidget({
    super.key,
    required this.weatherForecast,
  });

  // Weather forecast data for the next days.
  final Weather weatherForecast;

  @override
  Widget build(BuildContext context) {
    // Get the size of the screen.
    final Size size = MediaQuery.of(context).size;
    // Determine if the device is in portrait mode.
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return GestureDetector(
      onTap: () {
        // Dispatch an event to update the selected date in the WeatherBloc.
        BlocProvider.of<WeatherBloc>(context)
            .add(SelectDateEvent(weatherForecast.date));
      },
      child: Container(
        width: size.width > 600 && isPortrait ? 200 : 100,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the day of the week
            Text(
              DateFormat('EEE').format(DateTime.parse(weatherForecast.date)),
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: size.width > 600 && isPortrait ? 23 : 15,
              ),
              key: const Key('day_of_week_text'), // Key for testing
            ),
            const SizedBox(height: 10),
            // Display the weather animation
            WeatherAnimationWidget(
              weatherConditionName: weatherForecast.weatherCondition.name,
              key: const Key('weather_animation_widget'), // Key for testing
            ),
            const SizedBox(height: 10),
            // Display the min and max temperatures
            Text(
              '${weatherForecast.tempMin.toInt()}° / ${weatherForecast.tempMax.toInt()}°',
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width > 600 && isPortrait ? 23 : 15,
              ),
              key: const Key('temperature_range_text'), // Key for testing
            ),
          ],
        ),
      ),
    );
  }
}
