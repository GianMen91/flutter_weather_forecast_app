import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable{

  @override
  List<Object> get props => [];
}

class CheckLocationPermissionEvent extends WeatherEvent { }

class LoadWeatherEvent extends WeatherEvent { }

class AskForLocationPermissionEvent extends WeatherEvent { }