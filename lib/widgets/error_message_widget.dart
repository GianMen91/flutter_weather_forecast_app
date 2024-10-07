import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';

class ErrorMessageWidget extends StatelessWidget {

  const ErrorMessageWidget(
      {super.key, required this.errorMessage, required this.currentCityName});

  final String errorMessage;
  final String currentCityName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            errorMessage,
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Retry fetching the weather data
              if (currentCityName.isNotEmpty) {
                BlocProvider.of<WeatherBloc>(context).add(LoadWeatherEvent(currentCityName));
              } else {
                BlocProvider.of<WeatherBloc>(context).add(ClearWeatherForecastEvent());
              }
            },
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }
}