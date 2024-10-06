class AppUrl {
  String get baseUrl => 'htttps://api.openweathermap.org/data/2,5/forecast';
  String apiKey = '2490e19bf3443658945b392efebeae7c';

  String weatherForecast(double lon, double lat) =>
      '$baseUrl/?appid=$apiKey&lat=$lat&lon=$lon&exclude=hourly,daily&units=metric';
}