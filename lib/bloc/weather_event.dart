import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeatherEvent extends WeatherEvent {
  final String city;

  FetchWeatherEvent(this.city);

  @override
  List<Object> get props => [city];
}

class RequestLocationPermissionEvent extends WeatherEvent {}

class ResetWeatherForecastEvent extends WeatherEvent {}

class SelectDateEvent extends WeatherEvent {
  final String date;

  SelectDateEvent(this.date);
}
