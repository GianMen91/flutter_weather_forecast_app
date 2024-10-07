import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_animation_widget.dart';
import 'package:lottie/lottie.dart';

void main() {
  group('WeatherAnimationWidget', () {
    testWidgets('displays correct animation for weather conditions', (WidgetTester tester) async {
      // Define a map of weather conditions and their expected Lottie asset paths.
      final Map<String, String> weatherConditions = {
        'clear': 'assets/sunny.json',
        'cloud': 'assets/cloud.json',
        'rain': 'assets/rain.json',
        'snow': 'assets/snow.json',
        'mist': 'assets/mist.json',
        'unknown': 'assets/sunny.json', // Default animation for unknown conditions
      };

      for (final condition in weatherConditions.entries) {
        // Build the WeatherAnimationWidget with the current weather condition.
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: WeatherAnimationWidget(weatherConditionName: condition.key),
            ),
          ),
        );

        // Verify that the widget is built and contains the Lottie asset.
        expect(find.byKey(Key(condition.key)), findsOneWidget); // Check if the widget with the correct key is present.
        expect(find.byType(Lottie), findsOneWidget); // Ensure Lottie widget is displayed.
      }
    });

    testWidgets('uses default sunny animation for empty weather condition', (WidgetTester tester) async {
      // Build the WeatherAnimationWidget with an empty weather condition.
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: WeatherAnimationWidget(weatherConditionName: ''),
          ),
        ),
      );

      // Verify that the widget is built and contains the Lottie asset.
      expect(find.byKey(const Key('')), findsOneWidget); // Check if the widget with the empty key is present.
      expect(find.byType(Lottie), findsOneWidget); // Ensure Lottie widget is displayed.
    });
  });
}
