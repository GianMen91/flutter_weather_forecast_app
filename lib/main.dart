import 'package:flutter/material.dart';
import 'package:flutter_weather_forecast_app/weather_app.dart';

import 'module/module.dart';

void main() {
  final module = Module();
  module.initDependencies();

  runApp(WeatherApp(
    module: module,
  ));
}
