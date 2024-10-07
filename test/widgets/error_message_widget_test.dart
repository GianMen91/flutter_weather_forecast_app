import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_forecast_app/repository/weather_repository.dart';
import 'package:flutter_weather_forecast_app/widgets/error_message_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';

void main() {
  group('ErrorMessageWidget', () {
    late WeatherBloc weatherBloc;
    final weatherRepository = WeatherRepository();

    setUp(() {
      // Initialize the WeatherBloc before each test
      weatherBloc = WeatherBloc(openWeatherApiCall: weatherRepository);
    });

    testWidgets('displays error message and retry button', (WidgetTester tester) async {
      // Create a sample error message
      const String errorMessage = "Failed to load weather data";

      // Build the ErrorMessageWidget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: weatherBloc,
            child: const Scaffold(
              body: ErrorMessageWidget(
                errorMessage: errorMessage,
                currentCityName: 'Berlin',
              ),
            ),
          ),
        ),
      );

      // Check if the error message is displayed
      expect(find.byKey(const Key('errorMessageText')), findsOneWidget);
      expect(find.text(errorMessage), findsOneWidget);

      // Check if the retry button is present
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}

