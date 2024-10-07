import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';

import 'package:flutter_weather_forecast_app/models/weather.dart';
import 'package:flutter_weather_forecast_app/repository/weather_repository.dart';
import 'package:flutter_weather_forecast_app/widgets/next_days_forecasts_widget.dart';


void main() {
  group('NextDaysForecastWidget', () {
    // Sample weather data for testing
    final Weather mockWeatherData =
      Weather(
        date: '2024-10-07',
        temperature: 20.5,
        humidity: 65.0,
        wind: 5.5,
        pressure: 1012.0,
        weatherCondition: WeatherCondition.sun,
        tempMin: 15.5,
        tempMax: 20.6,
        cloudiness: 15.5, // Use appropriate weather condition
      );
    final weatherRepository = WeatherRepository();

    testWidgets('displays correct weather information', (WidgetTester tester) async {
      // Build the NextDaysForecastWidget with mock weather data
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider<WeatherBloc>(
            create: (context) => WeatherBloc(openWeatherApiCall: weatherRepository),
            child: Scaffold(
              body: NextDaysForecastWidget(weatherForecast: mockWeatherData),
            ),
          ),
        ),
      );

      // Verify the day of the week is displayed correctly
      expect(find.byKey(const Key('day_of_week_text')), findsOneWidget);
      expect(find.text('Mon'), findsOneWidget); // Adjust based on the date

      // Verify the weather animation is displayed
      expect(find.byKey(const Key('weather_animation_widget')), findsOneWidget);

      // Verify the temperature range is displayed correctly
      expect(find.byKey(const Key('temperature_range_text')), findsOneWidget);
      expect(find.text('15° / 20°'), findsOneWidget);
    });
  });
}
