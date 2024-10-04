import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/presentation/weather_app_main_screen.dart';
import 'package:go_router/go_router.dart';

import 'module/module.dart';

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key, required this.module});

  final Module module;

  GoRouter getRouter(Module module) {
    return GoRouter(routes: [
      GoRoute(
          path: '/',
          builder: (context, state) => BlocProvider(
                create: (context) => WeatherBloc(),
                child: const WeatherAppMainScreen(),
              ))
    ]);
  }

  @override
  Widget build(BuildContext context) {

    var router = getRouter(module);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: router.routerDelegate,
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
    );
  }
}
