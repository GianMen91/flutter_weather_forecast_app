import 'package:equatable/equatable.dart';

import '../models/weather.dart';

class WeatherState extends Equatable {
  final bool isLoading;

  final List<Weather> weatherForecast;
  final String currentCityName;

  const WeatherState(
      {this.weatherForecast = const [],
        this.currentCityName ="",
      this.isLoading = false,});

  @override
  List<Object?> get props => [weatherForecast, isLoading, currentCityName];

  WeatherState copyWith({
    List<Weather>? weatherForecast,
    String? currentCityName,
    bool? isLoading,
  }) {
    return WeatherState(
        weatherForecast: weatherForecast ?? this.weatherForecast,
        currentCityName: currentCityName ?? this.currentCityName,
        isLoading: isLoading ?? this.isLoading,
        );
  }
}
