import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/repository/weather_repository.dart';
import 'package:flutter_weather_forecast_app/screens/weather_forecast_screen.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of OpenWeatherApiCall
    final openWeatherApiCall = WeatherRepository();

    return BlocProvider(
      create: (context) => WeatherBloc(openWeatherApiCall: openWeatherApiCall),
      // Pass the OpenWeatherApiCall instance
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherForecastScreen(),
      ),
    );
  }
}
