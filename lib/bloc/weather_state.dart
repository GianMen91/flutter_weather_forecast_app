import 'package:equatable/equatable.dart';

import '../models/weather.dart';

class WeatherState extends Equatable {
  final bool isLoading;
  final List<Weather> weatherForecast;
  final String currentCityName;
  final String? errorMessage;
  final String selectedDate;

  const WeatherState({
    this.weatherForecast = const [],
    this.currentCityName = "",
    this.isLoading = false,
    this.errorMessage,
    this.selectedDate = "",
  });

  @override
  List<Object?> get props =>
      [weatherForecast, isLoading, currentCityName, errorMessage, selectedDate];

  WeatherState copyWith({
    List<Weather>? weatherForecast,
    String? currentCityName,
    bool? isLoading,
    String? errorMessage,
    String? selectedDate,
  }) {
    return WeatherState(
        weatherForecast: weatherForecast ?? this.weatherForecast,
        currentCityName: currentCityName ?? this.currentCityName,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
        selectedDate: selectedDate ?? this.selectedDate);
  }
}
