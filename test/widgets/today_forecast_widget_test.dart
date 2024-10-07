import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_forecast_app/widgets/today_forecast_widget.dart';
import 'package:flutter_weather_forecast_app/models/weather.dart';

void main() {
  group('TodayForecastWidget', () {
    // Sample weather data for testing
    final List<Weather> mockWeatherData = [
      Weather(
        date: '2024-10-07',
        temperature: 20.5,
        humidity: 65.0,
        wind: 5.5,
        pressure: 1012.0,
        weatherCondition: WeatherCondition.sun,
        tempMin: 15.5,
        tempMax: 22.6,
        cloudiness: 15.5, // Use appropriate weather condition
      ),
    ];

    testWidgets('displays correct weather information',
        (WidgetTester tester) async {
      // Build the TodayForecastWidget with mock weather data
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: TodayForecastWidget(listOfWeatherForecast: mockWeatherData),
          ),
        ),
      );

      // Verify the temperature is displayed correctly
      expect(find.byKey(const Key('temperature_text')), findsOneWidget);
      expect(find.text('20°'), findsOneWidget);

      // Verify the day of the week is displayed correctly
      expect(find.byKey(const Key('day_of_week_text')), findsOneWidget);
      expect(find.text('Monday'), findsOneWidget); // Adjust based on the date

      // Verify the weather condition is displayed correctly
      expect(find.byKey(const Key('weather_condition_text')), findsOneWidget);
      expect(find.text('sun'), findsOneWidget); // Adjust based on the condition

      // Verify the day of the week is displayed correctly
      expect(find.byKey(const Key('weather_animation_widget')), findsOneWidget);

      // Verify the humidity is displayed correctly
      expect(find.byKey(const Key('humidity_text')), findsOneWidget);
      expect(find.text('Humidity: 65 %'), findsOneWidget);

      // Verify the pressure is displayed correctly
      expect(find.byKey(const Key('pressure_text')), findsOneWidget);
      expect(find.text('Pressure: 1012 hPa'), findsOneWidget);

      // Verify the wind speed is displayed correctly
      expect(find.byKey(const Key('wind_text')), findsOneWidget);
      expect(find.text('Wind: 5 Km/h'), findsOneWidget);


    });
  });
}
