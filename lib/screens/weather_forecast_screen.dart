import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:flutter_weather_forecast_app/widgets/search_widget.dart';

import '../bloc/weather_event.dart';
import '../widgets/weather_widget.dart';

class WeatherForecastScreen extends StatelessWidget {
  const WeatherForecastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      return WillPopScope(
        onWillPop: () => _onWillPop(context),
        child: Scaffold(
          backgroundColor: const Color(0xFF63C4FD),
          body: _getWidgetDependingByPermission(state, bloc),
        ),
      );
    });
  }

  Future<bool> _onWillPop(BuildContext context) async {
    BlocProvider.of<WeatherBloc>(context)
        .add(ClearWeatherForecastEvent());
    return false;
  }

  Widget _getWidgetDependingByPermission(WeatherState state, WeatherBloc bloc) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (state.errorMessage != null) {
      // Show error screen with retry button
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Retry fetching the weather data
                if (state.currentCityName.isNotEmpty) {
                  bloc.add(LoadWeatherEvent(state.currentCityName));
                } else {
                  bloc.add(ClearWeatherForecastEvent());
                }
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.weatherForecast.isNotEmpty) {
      return  RefreshIndicator(
        onRefresh: () async {
          bloc.add(LoadWeatherEvent(state.currentCityName));
        },
        child: WeatherWidget(
            listOfWeatherForecast: state.weatherForecast,
            cityName: state.currentCityName),
      );
    } else {
      return SearchWidget(bloc: bloc);
    }
  }
}
