import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:permission_handler/permission_handler.dart';

import '../repository/weather_repository.dart';
import 'package:geolocator/geolocator.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepository openWeatherApiCall;

  WeatherBloc({required this.openWeatherApiCall})
      : super(const WeatherState()) {
    on<CheckLocationPermissionEvent>(_checkLocationPermissionEvent);
    on<AskForLocationPermissionEvent>(_askForLocationPermissionEvent);
    on<LoadWeatherEvent>(_loadWeatherEvent);
  }

  FutureOr<void> _loadWeatherEvent(
    LoadWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(state.copyWith(isLoading: true));

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    double longitude = position.longitude;
    double latitude = position.latitude;
    final weatherForecast = await openWeatherApiCall.loadWeatherForecast(
        longitude ?? 0.0, latitude ?? 0.0);
    emit(state.copyWith(isLoading: false,weatherForecast:weatherForecast,permissionState: PermissionState.granted ));
  }

  FutureOr<void> _checkLocationPermissionEvent(
    CheckLocationPermissionEvent event,
    Emitter<WeatherState> emit,
  ) async {
    var status = await Permission.location.status;

    if (status.isGranted) {
      add(LoadWeatherEvent());
    } else {
      emit(state.copyWith(permissionState: PermissionState.declined));
    }
  }

  FutureOr<void> _askForLocationPermissionEvent(
    AskForLocationPermissionEvent event,
    Emitter<WeatherState> emit,
  ) async {
    var status = await Permission.location.request();

    if (status.isGranted) {
      add(LoadWeatherEvent());
    } else {
      emit(state.copyWith(permissionState: PermissionState.declined));
    }
  }
}
