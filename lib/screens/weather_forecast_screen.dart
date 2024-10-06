import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:flutter_weather_forecast_app/screens/search_screen.dart';

import '../widgets/weather_widget.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      return Scaffold(
        body: _getWidgetDependingByPermission(state, bloc),
      );
    });
  }

  Widget _getWidgetDependingByPermission(WeatherState state, WeatherBloc bloc) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.blue,
        ),
      );
    }

    if (state.weatherForecast.isNotEmpty) {
      return WeatherWidget(listOfWeatherForecast: state.weatherForecast);
    } else {
      return SearchScreen(bloc: bloc);
    }
  }
}
