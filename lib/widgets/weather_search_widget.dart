import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:lottie/lottie.dart';

class WeatherSearchWidget extends StatelessWidget {
  WeatherSearchWidget({
    required this.weatherBloc, // Bloc for managing weather state
    super.key,
  });

  final WeatherBloc weatherBloc; // Bloc instance

  final TextEditingController _cityTextEditingController =
  TextEditingController(); // Controller for the city text field

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size; // Get the screen size

    return Center(
      child: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: size.width * 0.8, // Limit the width to 80% of the screen
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min, // Minimize the size of the column
            children: <Widget>[
              SizedBox(
                width: size.width > 600 ? 200 : 300, // Adjust size based on screen width
                child: Center(
                  child: Lottie.asset('assets/world.json'), // Animation asset
                ),
              ),
              SizedBox(height: size.width > 600 ? 20 : 30),
              BlocBuilder<WeatherBloc, WeatherState>(
                builder: (context, state) {
                  // Populate the text field with the current city name if available
                  if (state.currentCityName.isNotEmpty) {
                    _cityTextEditingController.text = state.currentCityName;
                  }
                  return Container(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          height: 50.0,
                          child: TextField(
                            controller: _cityTextEditingController, // Use controller for input
                            style: const TextStyle(
                              color: Colors.white, // Set text color to white
                            ),
                            decoration: InputDecoration(
                              prefixIcon: const Icon(
                                Icons.search,
                                color: Colors.white,
                              ),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.white), // Border color
                              ),
                              focusedBorder: const OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.white), // Border color when focused
                              ),
                              hintText: "City Name", // Hint text
                              hintStyle: const TextStyle(color: Colors.white),
                              suffixIcon: IconButton(
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  // Request location permission and update city name
                                  weatherBloc.add(RequestLocationPermissionEvent());
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          margin: const EdgeInsets.all(5.0),
                          height: 50.0,
                          width: double.infinity, // Full width within constraints
                          child: ElevatedButton(
                            style: ButtonStyle(
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                              backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                            onPressed: () {
                              // Trigger the API call with the entered city name
                              weatherBloc.add(FetchWeatherEvent(
                                  _cityTextEditingController.text.toLowerCase().trim()));
                            },
                            child: Text(
                              'Check Weather Forecast',
                              style: TextStyle(fontSize: size.width > 600 ? 18 : 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
