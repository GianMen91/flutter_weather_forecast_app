import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';

import '../repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository openWeatherApiCall;

  WeatherBloc({required this.openWeatherApiCall})
      : super(const WeatherState()) {
    on<AskForLocationPermissionEvent>(_askForLocationPermissionEvent);
    on<LoadWeatherEvent>(_loadWeatherEvent);
    on<ClearWeatherForecastEvent>(_clearWeatherForecastEvent);
  }

  FutureOr<void> _clearWeatherForecastEvent(
      ClearWeatherForecastEvent event,
      Emitter<WeatherState> emit,
      ) {
    emit(state.copyWith(weatherForecast: [],currentCityName: ""));
  }


  FutureOr<void> _askForLocationPermissionEvent(
      AskForLocationPermissionEvent event,
      Emitter<WeatherState> emit,
      ) async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      // If permission is granted, get the current location
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Fetch the city name using the location coordinates
      String cityName = await _getCityNameFromCoordinates(
          position.latitude, position.longitude);

      // Update the state with the city name, but don't call the API
      emit(state.copyWith(
        currentCityName: cityName
      ));
    }
  }

  FutureOr<void> _loadWeatherEvent(
      LoadWeatherEvent event,
      Emitter<WeatherState> emit,
      ) async {
    emit(state.copyWith(isLoading: true));

    try {
      // Use the provided city name to load the weather forecast
      final weatherForecast = await openWeatherApiCall.loadWeatherForecast(event.city);

      emit(state.copyWith(
        isLoading: false,
        weatherForecast: weatherForecast,
          currentCityName: event.city
      ));
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<String> _getCityNameFromCoordinates(double latitude, double longitude) async {
    // Use a geocoding service to get the city name from the coordinates
    List<Placemark> placemarks = await placemarkFromCoordinates(latitude, longitude);
    return placemarks.first.locality ?? 'Unknown City';
  }
}
