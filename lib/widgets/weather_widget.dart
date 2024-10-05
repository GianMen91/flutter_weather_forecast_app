import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/widgets/today_forecast.dart';

import '../model/weather_forecast.dart';
import 'next_days_forecasts.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key, required this.listOfWeatherForecast});

  final List<WeatherForecast> listOfWeatherForecast;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: listOfWeatherForecast.length,
            itemBuilder: (context, index) {
              if(index == 0){
                return  TodayForecast(listOfWeatherForecast: listOfWeatherForecast);
              }else {
                return NextDaysForecast(
                    listOfWeatherForecast: listOfWeatherForecast[index-1]);
              }
            }));
  }
}