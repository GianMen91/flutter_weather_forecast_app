import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWeatherEvent extends WeatherEvent {
  final String city;

  LoadWeatherEvent(this.city);

  @override
  List<Object> get props => [city];
}

class AskForLocationPermissionEvent extends WeatherEvent {}
