import 'package:equatable/equatable.dart';

import '../models/weather.dart';

class WeatherState extends Equatable {
  final bool isLoading;
  final List<Weather> forecastData;
  final String currentCityName;
  final String? errorMessage;
  final String selectedDate;

  const WeatherState({
    this.forecastData = const [],
    this.currentCityName = "",
    this.isLoading = false,
    this.errorMessage,
    this.selectedDate = "",
  });

  @override
  List<Object?> get props =>
      [forecastData, isLoading, currentCityName, errorMessage, selectedDate];

  WeatherState copyWith({
    List<Weather>? weatherForecast,
    String? currentCityName,
    bool? isLoading,
    String? errorMessage,
    String? selectedDate,
  }) {
    return WeatherState(
        forecastData: weatherForecast ?? forecastData,
        currentCityName: currentCityName ?? this.currentCityName,
        isLoading: isLoading ?? this.isLoading,
        errorMessage: errorMessage,
        selectedDate: selectedDate ?? this.selectedDate);
  }
}
