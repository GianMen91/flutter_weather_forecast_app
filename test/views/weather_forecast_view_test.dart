import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:flutter_weather_forecast_app/models/weather.dart';
import 'package:flutter_weather_forecast_app/repository/weather_repository.dart';
import 'package:flutter_weather_forecast_app/views/weather_forecast_view.dart';
import 'package:flutter_weather_forecast_app/widgets/error_message_widget.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_search_widget.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_widget.dart';

void main() {
  group('WeatherForecastView', () {

    final weatherRepository = WeatherRepository();

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

    testWidgets('displays loading indicator when state is loading',
            (WidgetTester tester) async {
          // Arrange: Create a mock WeatherBloc with loading state
          final weatherBloc = WeatherBloc(openWeatherApiCall: weatherRepository);
          weatherBloc.emit(
            const WeatherState(
              isLoading: true,
            ),
          );

          // Act: Build the WeatherForecastView widget
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<WeatherBloc>.value(
                value: weatherBloc,
                child: const Scaffold(body: WeatherForecastView()),
              ),
            ),
          );

          // Assert: Verify that the CircularProgressIndicator is displayed
          expect(find.byKey(const Key('loading_indicator')), findsOneWidget);
        });

    testWidgets('displays error message widget when there is an error',
            (WidgetTester tester) async {
          // Arrange: Create a mock WeatherBloc with an error message
          final weatherBloc = WeatherBloc(openWeatherApiCall: weatherRepository);
          weatherBloc.emit(
            const WeatherState(
              errorMessage: 'Failed to fetch weather data',
              currentCityName: 'Berlin',
            ),
          );

          // Act: Build the WeatherForecastView widget
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<WeatherBloc>.value(
                value: weatherBloc,
                child: const Scaffold(body: WeatherForecastView()),
              ),
            ),
          );

          // Assert: Verify that the ErrorMessageWidget is displayed
          expect(find.byKey(const Key('error_message_widget')), findsOneWidget);
          expect(find.text('Failed to fetch weather data'), findsOneWidget);
        });

    testWidgets('displays weather widget when weather data is available',
            (WidgetTester tester) async {
          // Arrange: Create a mock WeatherBloc with weather data
          final weatherBloc = WeatherBloc(openWeatherApiCall: weatherRepository);
          weatherBloc.emit(
             WeatherState(
              weatherForecast: mockWeatherData,
              currentCityName: 'Berlin',
              selectedDate: '2024-10-07',
            ),
          );

          // Act: Build the WeatherForecastView widget
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<WeatherBloc>.value(
                value: weatherBloc,
                child: const Scaffold(body: WeatherForecastView()),
              ),
            ),
          );

          // Assert: Verify that the WeatherWidget is displayed
          expect(find.byKey(const Key('weather_widget')), findsOneWidget);
        });

    testWidgets('displays search widget when weather forecast is empty',
            (WidgetTester tester) async {
          // Arrange: Create a mock WeatherBloc with empty weather data
          final weatherBloc = WeatherBloc(openWeatherApiCall: weatherRepository);
          weatherBloc.emit(
            const WeatherState(
              weatherForecast: [],
              currentCityName: '',
            ),
          );

          // Act: Build the WeatherForecastView widget
          await tester.pumpWidget(
            MaterialApp(
              home: BlocProvider<WeatherBloc>.value(
                value: weatherBloc,
                child: const Scaffold(body: WeatherForecastView()),
              ),
            ),
          );

          // Assert: Verify that the WeatherSearchWidget is displayed
          expect(find.byKey(const Key('weather_search_widget')), findsOneWidget);
        });
  });
}
