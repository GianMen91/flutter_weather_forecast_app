import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'module/module.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key, required this.module});

  final Module module;

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
    );
  }
}