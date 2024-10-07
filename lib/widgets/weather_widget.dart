import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/widgets/today_forecast_widget.dart';
import 'package:intl/intl.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../models/weather.dart';
import 'next_days_forecasts_widget.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({
    super.key, // Key for the widget, used in the widget tree
    required this.weatherForecasts, // List of weather forecasts
    required this.cityName, // Name of the city
    required this.selectedDateString, // Selected date for the forecast
  });

  final List<Weather> weatherForecasts;
  final String cityName;
  final String selectedDateString;

  @override
  Widget build(BuildContext context) {
    late final Weather selectedWeather; // Declare selectedWeather

    final Size size = MediaQuery.of(context).size; // Get device size
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait; // Check orientation

    // Determine which weather data to show based on selectedDateString
    if (selectedDateString.isNotEmpty) {
      selectedWeather = weatherForecasts
          .firstWhere((weather) => weather.date == selectedDateString);
    } else {
      selectedWeather = weatherForecasts.firstWhere((weather) =>
      weather.date == DateFormat('yyyy-MM-dd').format(DateTime.now()));
    }

    return SafeArea(
      child: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8, // Limit width to 80%
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: size.width > 600 && isPortrait ? 5 : 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on,
                            color: Colors.white,
                            size: size.width > 600 && isPortrait ? 38 : 25),
                        const SizedBox(width: 10),
                        Text(
                          cityName.toUpperCase(),
                          style: TextStyle(
                            fontSize: size.width > 600 && isPortrait ? 38 : 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_back_rounded,
                          color: Colors.white,
                          size: size.width > 600 && isPortrait ? 38 : 25),
                      onPressed: () {
                        // Dispatch event to reset weather forecast
                        BlocProvider.of<WeatherBloc>(context)
                            .add(ResetWeatherForecastEvent());
                      },
                    ),
                  ],
                ),
                SizedBox(height: size.width > 600 && isPortrait ? 30 : 20),
                Center(
                  child: TodayForecastWidget(
                    // Pass selected weather to TodayForecastWidget
                    listOfWeatherForecast: [selectedWeather],
                    key: const Key('today_forecast_widget'), // Key for testing
                  ),
                ),
                SizedBox(height: size.width > 600 && isPortrait ? 30 : 20),
                // Title for weekly weather forecast
                Text(
                  'Weekly Weather Forecast',
                  style: TextStyle(
                    fontSize: size.width > 600 && isPortrait ? 38 : 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: size.width > 600 && isPortrait ? 60 : 40),
                // Display next days' forecasts in a horizontal scrollable row
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      weatherForecasts.length,
                          (index) => NextDaysForecastWidget(
                        // Pass each day's weather forecast
                        weatherForecast: weatherForecasts[index],
                        key: Key('next_day_forecast_widget_$index'), // Key for each widget
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
