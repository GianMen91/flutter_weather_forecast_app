// Import the Equatable package to enable value equality for the WeatherEvent classes.
import 'package:equatable/equatable.dart';

// The WeatherEvent abstract class is the base class for all weather-related events.
// It extends Equatable, making it easy to compare instances of events in the app.
abstract class WeatherEvent extends Equatable {
  @override
  // Define props as an empty list for the base class, since specific properties
  // are only needed in subclasses.
  List<Object> get props => [];
}

// FetchWeatherEvent is triggered when the user wants to fetch weather data for a given city.
class FetchWeatherEvent extends WeatherEvent {
  // The name of the city for which the weather forecast should be fetched.
  final String city;

  // Constructor to initialize the FetchWeatherEvent with the provided city name.
  FetchWeatherEvent(this.city);

  // Override props to include the city, allowing Equatable to use it for comparison.
  @override
  List<Object> get props => [city];
}

// RequestLocationPermissionEvent is triggered when the app needs to request
// location permissions from the user. This can be useful for fetching weather data
// based on the user's current location.
class RequestLocationPermissionEvent extends WeatherEvent {}

// ResetWeatherForecastEvent is triggered to clear the current weather forecast data.
// This is used when resetting the app state, such as navigating back to a previous screen.
class ResetWeatherForecastEvent extends WeatherEvent {}

// SelectDateEvent is triggered when the user selects a specific date in the weather forecast.
// This event updates the UI to show the weather forecast details for the selected date.
class SelectDateEvent extends WeatherEvent {
  // The selected date as a string, used to filter or display weather data for that day.
  final String date;

  // Constructor to initialize the SelectDateEvent with the provided date.
  SelectDateEvent(this.date);

  // Override props to include the date, making it part of the event's comparison logic.
  @override
  List<Object> get props => [date];
}
