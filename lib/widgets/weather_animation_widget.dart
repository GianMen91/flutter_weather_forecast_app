import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class WeatherAnimationWidget extends StatelessWidget {
  const WeatherAnimationWidget({super.key, required this.weatherConditionName});

  // The name of the weather condition to display an animation for.
  final String weatherConditionName;

  @override
  Widget build(BuildContext context) {
    // Use the Lottie animation corresponding to the weather condition.
    return Lottie.asset(getAnimationPath(weatherConditionName), key: Key(weatherConditionName));
  }

  // Returns the animation path based on the weather condition name.
  // If [weatherConditionName] is null or unrecognized, it defaults to 'sunny'.
  String getAnimationPath(String? weatherConditionName) {
    if (weatherConditionName == null) return 'assets/sunny.json';

    // Map different weather conditions to their respective animation paths.
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
