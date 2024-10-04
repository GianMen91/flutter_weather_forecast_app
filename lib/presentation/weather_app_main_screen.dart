import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';

import '../bloc/weather_event.dart';

class WeatherAppMainScreen extends StatelessWidget {
  const WeatherAppMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<WeatherBloc>(context);
    return BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          return Scaffold(
            body: PermissionWidget(bloc: bloc),
          );
        }
    );
  }
}

class PermissionWidget extends StatelessWidget {
  const PermissionWidget({super.key, required this.bloc});

  final WeatherBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: const BoxDecoration(
                shape: BoxShape.circle
            ),
            child: const Icon(Icons.location_on, size: 100,),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 30,vertical: 15),
            child: Text('Allow location permission to get your city location', textAlign: TextAlign.center),
          ),
          GestureDetector(
            onTap: ()=> bloc.add(AskForLocationPermissionEvent()),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              decoration:  BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(20)
              ),
              child: const Text('Give Permission', style: TextStyle(color: Colors.white),),
            ),
          )
        ],
      ),
    );
  }
}

