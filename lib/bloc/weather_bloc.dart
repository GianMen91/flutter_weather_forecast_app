import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:permission_handler/permission_handler.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(const WeatherState()){

  on<CheckLocationPermissionEvent>(_checkLocationPermissionEvent);
  }


FutureOr<void> _checkLocationPermissionEvent(
    CheckLocationPermissionEvent event,
    Emitter<WeatherState> emit,
    ) async {
        var  status = await Permission.location.status;

        if(status.isGranted){

        }else {
            emit(state.copyWith(permissionState: PermissionState.declined));
        }
    }
}
