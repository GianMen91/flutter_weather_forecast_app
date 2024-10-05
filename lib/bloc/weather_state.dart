import 'package:equatable/equatable.dart';

import '../model/weather_forecast.dart';

class WeatherState extends Equatable {
  final bool isLoading;
  final PermissionState permissionState;
  final List<WeatherForecast> weatherForecast;

  const WeatherState(
      {this.weatherForecast = const [],
      this.isLoading = false,
      this.permissionState = PermissionState.declined});

  @override
  List<Object?> get props => [weatherForecast, isLoading, permissionState];

  WeatherState copyWith({
    List<WeatherForecast>? weatherForecast,
    bool? isLoading,
    PermissionState? permissionState,
  }) {
    return WeatherState(
        weatherForecast: weatherForecast ?? this.weatherForecast,
        isLoading: isLoading ?? this.isLoading,
        permissionState: permissionState ?? this.permissionState);
  }
}

enum PermissionState { granted, declined }
