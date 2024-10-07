import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/repository/weather_repository.dart';
import 'package:flutter_weather_forecast_app/views/weather_forecast_view.dart';

// Entry point of the Weather Forecast App
class WeatherForecastApp extends StatelessWidget {
  const WeatherForecastApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of WeatherRepository which handles API calls.
    final weatherRepository = WeatherRepository();

    return BlocProvider(
      // Initialize the WeatherBloc using the WeatherRepository instance.
      create: (context) => WeatherBloc(openWeatherApiCall: weatherRepository),
      // Wrap the widget tree with the WeatherBloc provider, so it can be accessed by any widget in the tree.
      child: const MaterialApp(
        // Disable the debug banner in the app.
        debugShowCheckedModeBanner: false,
        // Set the home screen of the app to be the WeatherForecastView.
        home: WeatherForecastView(),
      ),
    );
  }
}
