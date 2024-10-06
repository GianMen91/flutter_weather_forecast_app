import 'package:equatable/equatable.dart';

import '../models/weather.dart';

class WeatherState extends Equatable {
  final bool isLoading;
  final PermissionState permissionState;
  final List<Weather> weatherForecast;

  const WeatherState(
      {this.weatherForecast = const [],
      this.isLoading = false,
      this.permissionState = PermissionState.declined});

  @override
  List<Object?> get props => [weatherForecast, isLoading, permissionState];

  WeatherState copyWith({
    List<Weather>? weatherForecast,
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
