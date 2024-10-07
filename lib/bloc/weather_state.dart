import 'package:equatable/equatable.dart';
import '../models/weather.dart';

class WeatherState extends Equatable {
  // Indicates whether the app is currently loading weather data.
  final bool isLoading;

  // A list of Weather objects representing the forecast data for multiple days.
  final List<Weather> weatherForecast;

  // The name of the currently searched or selected city.
  final String currentCityName;

  // An optional field to store error messages (e.g., when an API request fails).
  final String? errorMessage;

  // A string representing the currently selected date in the weather forecast.
  final String selectedDate;

  // Constructor with named parameters, providing default values for some fields.
  const WeatherState({
    this.weatherForecast = const [],
    this.currentCityName = "",
    this.isLoading = false,
    this.errorMessage,
    this.selectedDate = "",
  });

  // Override props to include the properties that should be used for equality checks.
  // Equatable uses this list to determine if two WeatherState objects are equal.
  @override
  List<Object?> get props => [
        weatherForecast,
        isLoading,
        currentCityName,
        errorMessage,
        selectedDate,
      ];

  // The copyWith method creates a new WeatherState object by copying existing properties
  // and allowing the user to override any of the properties with new values.
  WeatherState copyWith({
    List<Weather>? weatherForecast,
    String? currentCityName,
    bool? isLoading,
    String? errorMessage,
    String? selectedDate,
  }) {
    return WeatherState(
      // Use the new value for `weatherForecast` if provided, otherwise, keep the current value.
      weatherForecast: weatherForecast ?? this.weatherForecast,

      // Use the new value for `currentCityName` if provided, otherwise, keep the current value.
      currentCityName: currentCityName ?? this.currentCityName,

      // Use the new value for `isLoading` if provided, otherwise, keep the current value.
      isLoading: isLoading ?? this.isLoading,

      // Use the new value for `errorMessage` if provided, otherwise, keep the current value.
      errorMessage: errorMessage,

      // Use the new value for `selectedDate` if provided, otherwise, keep the current value.
      selectedDate: selectedDate ?? this.selectedDate,
    );
  }
}
