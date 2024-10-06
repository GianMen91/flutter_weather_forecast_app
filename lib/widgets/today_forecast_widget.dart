import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import '../models/weather.dart';

class TodayForecastWidget extends StatelessWidget {
  const TodayForecastWidget({
    super.key,
    required this.listOfWeatherForecast,
  });

  final List<Weather> listOfWeatherForecast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Row(
          children: [
            Text(
              '${listOfWeatherForecast[0].temperature.toInt()}°',
              style: const TextStyle(
                fontSize: 60,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 60),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              // Aligns children to the start
              children: [
                Container(
                  alignment: Alignment.centerLeft, // Align to left
                  child: Text(
                    DateFormat('EEEE')
                        .format(DateTime.parse(listOfWeatherForecast[0].date)),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 26,
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft, // Align to left
                  child: Text(
                    listOfWeatherForecast[0].weatherCondition.name,
                    style: const TextStyle(
                      fontSize: 21,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
        const SizedBox(height: 20),
        // Placeholder for weather icon (can use network image or custom icon)
        SizedBox(
          width: 200,
          child: Center(
            child: Lottie.asset(getAnimation(listOfWeatherForecast[0].weatherCondition.name)),
          ),
        ),
        const SizedBox(height: 20),
        Column(
          children: [
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text(
                    'Humidity: ${listOfWeatherForecast[0].humidity.toInt()} %',
                    style: const TextStyle(color: Colors.white, fontSize: 15))),
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text(
                    'Pressure: ${listOfWeatherForecast[0].pressure.toInt()} hPa',
                    style: const TextStyle(color: Colors.white, fontSize: 15))),
            Container(
                alignment: Alignment.centerLeft, // Align to left
                child: Text('Wind: ${listOfWeatherForecast[0].wind.toInt()} Km/h',
                    style: const TextStyle(color: Colors.white, fontSize: 15))),
          ],
        ),
      ],
    );
  }

  String getAnimation(String? weatherConditionName){
    if(weatherConditionName == null) return 'assets/sunny.json';

    switch(weatherConditionName.toLowerCase()){
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
