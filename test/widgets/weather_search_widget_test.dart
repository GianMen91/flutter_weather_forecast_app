import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/repository/weather_repository.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_search_widget.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_weather_forecast_app/models/weather.dart';

// Create a mock class for the WeatherRepository
class MockWeatherRepository extends Mock implements WeatherRepository {}

void main() {
  group('WeatherSearchWidget', () {

    final weatherRepository = WeatherRepository();

    testWidgets('WeatherSearchWidget displays correctly', (WidgetTester tester) async {
      // Build the WeatherSearchWidget
      await tester.pumpWidget(
        MaterialApp(
          home: BlocProvider.value(
            value: WeatherBloc(openWeatherApiCall: weatherRepository),
            child: Scaffold(
              body: WeatherSearchWidget(weatherBloc: WeatherBloc(openWeatherApiCall: weatherRepository)),
            ),
          ),
        ),
      );

      // Check if the text field for city name is present
      expect(find.byType(TextField), findsOneWidget);

      // Check if the button is present
      expect(find.byType(ElevatedButton), findsOneWidget);
    });
  });
}
