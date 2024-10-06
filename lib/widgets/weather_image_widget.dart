import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherImageWidget extends StatelessWidget {
  const WeatherImageWidget({super.key, required this.weatherConditionName});

  final String weatherConditionName;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(getAnimation(weatherConditionName));
  }

  String getAnimation(String? weatherConditionName) {
    if (weatherConditionName == null) return 'assets/sunny.json';

    switch (weatherConditionName.toLowerCase()) {
      case 'cloud':
      case 'smoke':
      case 'haze':
      case 'dust':
      case 'fog':
        return 'assets/cloud.json';
      case 'rain':
      case 'drizzle':
      case 'shower rain':
      case 'thunderstorm':
        return 'assets/rain.json';
      case 'clear':
        return 'assets/sunny.json';
      case 'mist':
        return 'assets/mist.json';
      case 'snow':
        return 'assets/snow.json';
      default:
        return 'assets/sunny.json';
    }
  }
}
