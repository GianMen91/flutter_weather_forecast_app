import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(
      {super.key, required this.errorMessage, required this.currentCityName});

  final String errorMessage; // Message to be displayed in case of an error
  final String currentCityName; // Current city name for retry logic

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // Get the screen size

    return Center(
      child: ConstrainedBox(
        // Use ConstrainedBox to limit the width of the child elements
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.8, // Set max width to 80% of the screen width
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Center the column vertically
          mainAxisSize: MainAxisSize.min, // Size the column to fit its children
          children: [
            Text(
              errorMessage, // Display the error message
              style: TextStyle(
                color: Colors.white, // Set text color to white
                fontSize: size.width > 600 ? 30 : 18, // Adjust font size based on screen width
              ),
              textAlign: TextAlign.center, // Center the text
              key: const Key('errorMessageText'), // Key for automated tests
            ),
            SizedBox(height: size.width > 600 ? 40 : 30), // Spacer with dynamic height
            Container(
              margin: const EdgeInsets.all(5.0), // Margin around the button
              height: 50.0, // Fixed height for the button
              width: double.infinity, // Take the full width within the constraints
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                  MaterialStateProperty.all<Color>(Colors.blue), // Button text color
                  backgroundColor:
                  MaterialStateProperty.all<Color>(Colors.white), // Button background color
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rounded corners
                    ),
                  ),
                ),
                onPressed: () {
                  // Retry fetching the weather data
                  if (currentCityName.isNotEmpty) {
                    // If a city name is provided, fetch weather for that city
                    BlocProvider.of<WeatherBloc>(context)
                        .add(FetchWeatherEvent(currentCityName));
                  } else {
                    // If no city name, reset the weather forecast
                    BlocProvider.of<WeatherBloc>(context)
                        .add(ResetWeatherForecastEvent());
                  }
                },
                child: Text(
                  'Retry', // Button label
                  style: TextStyle(fontSize: size.width > 600 ? 18 : 16), // Adjust font size based on screen width
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
