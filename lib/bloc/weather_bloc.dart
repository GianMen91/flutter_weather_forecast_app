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
  // A reference to the WeatherRepository that handles weather data fetching.
  final WeatherRepository openWeatherApiCall;

  // The WeatherBloc constructor initializes the Bloc with an initial state.
  WeatherBloc({required this.openWeatherApiCall})
      : super(const WeatherState()) {
    // Register the various event handlers in the Bloc constructor.
    on<RequestLocationPermissionEvent>(_onRequestLocationPermission);
    on<FetchWeatherEvent>(_onFetchWeather);
    on<ResetWeatherForecastEvent>(_onResetWeatherForecast);
    on<SelectDateEvent>(_onSelectDate);
  }

  // Handler for ResetWeatherForecastEvent: Resets the weather forecast state.
  FutureOr<void> _onResetWeatherForecast(
    ResetWeatherForecastEvent event,
    Emitter<WeatherState> emit,
  ) {
    // Emit a new state with cleared forecast data, city name, and selected date.
    emit(state
        .copyWith(weatherForecast: [], currentCityName: "", selectedDate: ""));
  }

  // Handler for SelectDateEvent: Updates the state with the selected date.
  FutureOr<void> _onSelectDate(
    SelectDateEvent event,
    Emitter<WeatherState> emit,
  ) {
    // Emit a new state with the selected date provided by the event.
    emit(state.copyWith(selectedDate: event.date));
  }

  // Handler for RequestLocationPermissionEvent: Requests location permission and updates the city name based on the current location.
  FutureOr<void> _onRequestLocationPermission(
    RequestLocationPermissionEvent event,
    Emitter<WeatherState> emit,
  ) async {
    // Request location permission from the user.
    var status = await Permission.location.request();

    // If permission is granted, get the current location coordinates.
    if (status.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      // Fetch the city name using the location coordinates.
      String cityName = await _fetchCityNameFromCoordinates(
          position.latitude, position.longitude);

      // Update the state with the fetched city name, without making an API call.
      emit(state.copyWith(currentCityName: cityName));
    }
  }

  // Handler for FetchWeatherEvent: Fetches weather data for a given city and updates the state accordingly.
  FutureOr<void> _onFetchWeather(
    FetchWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    // Emit a new state with isLoading set to true to indicate that data is being loaded.
    emit(state.copyWith(isLoading: true));

    try {
      // Fetch the weather forecast data for the provided city name using the WeatherRepository.
      final weatherForecast =
          await openWeatherApiCall.fetchWeatherForecast(event.city);

      // Check if the weather forecast data is empty.
      if (weatherForecast.isEmpty) {
        throw Exception(
            'No weather data available'); // Throw an exception if no data is available.
      }

      // Emit the state with the fetched weather data and update the city name.
      emit(state.copyWith(
        isLoading: false,
        weatherForecast: weatherForecast,
        currentCityName: event.city,
      ));
    } on Exception catch (e) {
      // Print the error message if in debug mode.
      if (kDebugMode) {
        print(e);
      }
      // Emit an error state with a descriptive error message.
      emit(state.copyWith(
        isLoading: false,
        errorMessage: '$e. Please try again.',
      ));
    }
  }

  // A helper function to fetch the city name based on the provided coordinates (latitude and longitude).
  Future<String> _fetchCityNameFromCoordinates(
      double latitude, double longitude) async {
    // Use the Geocoding package to get a list of placemarks (location data) for the given coordinates.
    List<Placemark> placemarks =
        await placemarkFromCoordinates(latitude, longitude);

    // Return the locality (city name) from the first placemark in the list, or 'Unknown City' if it's null.
    return placemarks.first.locality ?? 'Unknown City';
  }
}
