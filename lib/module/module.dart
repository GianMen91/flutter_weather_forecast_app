import 'package:dio/dio.dart';

import '../network/app_url.dart';
import '../network/open_weather_api_call.dart';

class Module {
  late final AppUrl _appUrls;
  late final Dio _dio;
  late final OpenWeatherApiCall openWeatherApiCall;

  void initDependencies() {
    _appUrls = AppUrl();
    _dio = Dio();
    openWeatherApiCall = OpenWeatherApiCall(
      appUrl: _appUrls,
      dio: _dio,
    );
  }
}