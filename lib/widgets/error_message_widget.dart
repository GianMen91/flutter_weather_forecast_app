import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';

class ErrorMessageWidget extends StatelessWidget {
  const ErrorMessageWidget(
      {super.key, required this.errorMessage, required this.currentCityName});

  final String errorMessage;
  final String currentCityName;

  @override
  Widget build(BuildContext context) {

    final Size size = MediaQuery.of(context).size;

    return Center(
      child: ConstrainedBox(
        // Use ConstrainedBox to limit the width of the child elements
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width *
              0.8, // Set max width to 80% of the screen width
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              errorMessage,
              style:  TextStyle(color: Colors.white,  fontSize: size.width > 600 ? 30 : 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: size.width > 600 ? 40 : 30),
            Container(
              margin: const EdgeInsets.all(5.0),
              height: 50.0,
              width: double.infinity,
              // Take the full width within the constraints
              child: ElevatedButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
                onPressed: () {
                  // Retry fetching the weather data
                  if (currentCityName.isNotEmpty) {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(LoadWeatherEvent(currentCityName));
                  } else {
                    BlocProvider.of<WeatherBloc>(context)
                        .add(ClearWeatherForecastEvent());
                  }
                },
                child:  Text('Retry',
                    style:  TextStyle(fontSize: size.width > 600 ? 18 : 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
