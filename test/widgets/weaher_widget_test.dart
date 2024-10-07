import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_forecast_app/models/weather.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_widget.dart';

void main() {
  testWidgets('WeatherWidget displays city name and forecast', (WidgetTester tester) async {
    // Sample weather data for testing
    final weatherForecasts = [
      Weather(
        date: '2024-10-07',
        temperature: 20.5,
        tempMin: 18.0,
        tempMax: 23.0,
        humidity: 65.0,
        wind: 5.5,
        pressure: 1012.0,
        cloudiness: 10.0,
        weatherCondition: WeatherCondition.sun,
      ),
      Weather(
        date: '2024-10-08',
        temperature: 19.0,
        tempMin: 17.0,
        tempMax: 21.0,
        humidity: 70.0,
        wind: 4.0,
        pressure: 1010.0,
        cloudiness: 20.0,
        weatherCondition: WeatherCondition.cloud,
      ),
    ];

    // Build the WeatherWidget with sample data
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: WeatherWidget(
            weatherForecasts: weatherForecasts,
            cityName: 'London',
            selectedDateString: '2024-10-07',
          ),
        ),
      ),
    );

    // Check if the city name is displayed
    expect(find.text('LONDON'), findsOneWidget);

    // Check if the weekly forecast title is displayed
    expect(find.text('Weekly Weather Forecast'), findsOneWidget);

    // Check if the TodayForecastWidget is present
    expect(find.byKey(const Key('today_forecast_widget')), findsOneWidget);

    // Check if the NextDaysForecastWidget is present
    expect(find.byKey(const Key('next_day_forecast_widget_0')), findsOneWidget);
    expect(find.byKey(const Key('next_day_forecast_widget_1')), findsOneWidget);
  });
}
