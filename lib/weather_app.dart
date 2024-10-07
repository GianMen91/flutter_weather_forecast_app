import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/repository/weather_repository.dart';
import 'package:flutter_weather_forecast_app/views/weather_forecast_view.dart';

class WeatherForecastApp extends StatelessWidget {
  const WeatherForecastApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Create an instance of OpenWeatherApiCall
    final weatherRepository = WeatherRepository();

    return BlocProvider(
      create: (context) => WeatherBloc(openWeatherApiCall: weatherRepository),
      // Pass the OpenWeatherApiCall instance
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: WeatherForecastView(),
      ),
    );
  }
}
