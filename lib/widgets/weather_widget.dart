import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/widgets/today_forecast_widget.dart';
import 'package:intl/intl.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../models/weather.dart';
import 'next_days_forecasts_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget(
      {super.key,
      required this.weatherForecasts,
      required this.cityName,
      required this.selectedDateString});

  final List<Weather> weatherForecasts;
  final String cityName;
  final String selectedDateString;

  @override
  Widget build(BuildContext context) {
    final Weather selectedWeather;

    final Size size = MediaQuery.of(context).size;

    if (selectedDateString.isNotEmpty) {
      selectedWeather = weatherForecasts
          .firstWhere((weather) => weather.date == selectedDateString);
    } else {
      selectedWeather = weatherForecasts.firstWhere((weather) =>
          weather.date == DateFormat('yyyy-MM-dd').format(DateTime.now()));
    }

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
            SizedBox(height: size.width > 600 ? 5 : 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.location_on,
                        color: Colors.white, size: size.width > 600 ? 38 : 25),
                    const SizedBox(width: 10),
                    Text(
                      cityName.toUpperCase(),
                      style:  TextStyle(
                        fontSize: size.width > 600 ? 38 : 25,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                IconButton(
                  icon: Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.white,
                      size: size.width > 600 ? 38 : 25
                  ),
                  onPressed: () {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(ResetWeatherForecastEvent());
                  },
                ),
              ],
            ),
            SizedBox(height: size.width > 600 ? 30 : 20),
            Center(
                child: TodayForecastWidget(
                    listOfWeatherForecast: [selectedWeather])),
            SizedBox(height: size.width > 600 ? 30 : 20),
            // Next Days Forecast - Display horizontally in a row
            Text(
              'Weekly Weather Forecast',
              style: TextStyle(
                  fontSize: size.width > 600 ? 38 : 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            SizedBox(height: size.width > 600 ? 60 : 40),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(
                  weatherForecasts.length,
                  (index) => NextDaysForecastWidget(
                    weatherForecast: weatherForecasts[index],
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
