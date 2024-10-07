import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:flutter_weather_forecast_app/widgets/search_widget.dart';

import '../bloc/weather_event.dart';
import '../widgets/error_message_widget.dart';
import '../widgets/weather_widget.dart';

class WeatherForecastView extends StatelessWidget {
  const WeatherForecastView({super.key});

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      // ignore: deprecated_member_use
      return WillPopScope(
        onWillPop: () => _handleBackNavigation(context),
        child: Scaffold(
          backgroundColor: const Color(0xFF63C4FD),
          body: _buildContentForWeatherState(state, weatherBloc),
        ),
      );
    });
  }

  Future<bool> _handleBackNavigation(BuildContext context) async {
    BlocProvider.of<WeatherBloc>(context).add(ResetWeatherForecastEvent());
    return false;
  }

  Widget _buildContentForWeatherState(
      WeatherState state, WeatherBloc weatherBloc) {
    if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.white,
        ),
      );
    }

    if (state.errorMessage != null) {
      return ErrorMessageWidget(
        errorMessage: state.errorMessage!,
        currentCityName: state.currentCityName,
      );
    }

    if (state.forecastData.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async {
          weatherBloc.add(FetchWeatherEvent(state.currentCityName));
        },
        child: WeatherWidget(
          selectedDate: state.selectedDate,
          listOfWeatherForecast: state.forecastData,
          cityName: state.currentCityName,
        ),
      );
    } else {
      return SearchWidget(bloc: weatherBloc);
    }
  }
}
