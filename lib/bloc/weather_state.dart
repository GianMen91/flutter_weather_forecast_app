import 'package:equatable/equatable.dart';

class WeatherState extends Equatable{

  final bool isLoading;
  final PermissionState permissionState;

  const WeatherState({required this.isLoading, required this.permissionState});

  @override
  List<Object?> get props => throw UnimplementedError();
}

enum PermissionState { granted, declined }


