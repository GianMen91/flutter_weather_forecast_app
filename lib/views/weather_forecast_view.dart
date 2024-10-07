import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_search_widget.dart';

import '../bloc/weather_event.dart';
import '../widgets/error_message_widget.dart';
import '../widgets/weather_widget.dart';

class WeatherForecastView extends StatelessWidget {
  const WeatherForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the WeatherBloc from the context
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);

    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        // ignore: deprecated_member_use
        return WillPopScope(
          onWillPop: () => _handleBackNavigation(context),
          key: const Key('will_pop_scope'),// Key for testing WillPopScope
          child: Scaffold(
            backgroundColor: const Color(0xFF63C4FD),
            body: _buildContentForWeatherState(state, weatherBloc),
          ),
        );
      },
    );
  }

  // Handles back button navigation by resetting the weather forecast state.
  Future<bool> _handleBackNavigation(BuildContext context) async {
    BlocProvider.of<WeatherBloc>(context).add(ResetWeatherForecastEvent());
    return false;
  }

  // Builds different widgets based on the state of the WeatherBloc.
  Widget _buildContentForWeatherState(WeatherState state, WeatherBloc weatherBloc) {
    // Loading state: Show a progress indicator.
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
          key: Key('loading_indicator'), // Key for testing loading indicator
        ),
      );
    }

    // Error state: Show an error message widget.
    if (state.errorMessage != null) {
      return ErrorMessageWidget(
        errorMessage: state.errorMessage!,
        currentCityName: state.currentCityName,
        key: const Key('error_message_widget'), // Key for testing error message
      );
    }

    // Success state: Show weather information if weather data is available.
    if (state.weatherForecast.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          // Refresh the weather data.
          weatherBloc.add(FetchWeatherEvent(state.currentCityName));
        },
        key: const Key('refresh_indicator'), // Key for testing refresh indicator
        child: WeatherWidget(
          selectedDateString: state.selectedDate,
          weatherForecasts: state.weatherForecast,
          cityName: state.currentCityName,
          key: const Key('weather_widget'), // Key for testing weather widget
        ),
      );
    } else {
      // Initial state: Show the search widget for entering a city name.
      return WeatherSearchWidget(
        weatherBloc: weatherBloc,
        key: const Key('weather_search_widget'), // Key for testing search widget
      );
    }
  }
}
