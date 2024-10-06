import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';
import 'package:lottie/lottie.dart';

class SearchScreen extends StatefulWidget {
  final WeatherBloc bloc;

  const SearchScreen({required this.bloc, super.key});

  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF48BEFE), // Set the background color to #48BEFE
      body: Center( // Use Center to center the SingleChildScrollView
        child: SingleChildScrollView(
          child: ConstrainedBox( // Use ConstrainedBox to limit the width of the child elements
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.8, // Set max width to 80% of the screen width
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center horizontally
              mainAxisSize: MainAxisSize.min, // Minimize the size of the column
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: Center(
                    child: Lottie.asset('assets/world.json'),
                  ),
                ),
                BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    // Populate the text field with the current city name if available
                    if (state.currentCityName.isNotEmpty) {
                      _controller.text = state.currentCityName;
                    }

                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            height: 50.0,
                            child: TextField(
                              controller: _controller,
                              style: const TextStyle(
                                color: Colors.white, // Set the text color to white
                              ),
                              decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white), // Set the border color to white
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(color: Colors.white), // Border color when focused
                                ),
                                hintText: "City Name",
                                hintStyle: const TextStyle(color: Colors.white),
                                suffixIcon: IconButton(
                                  icon: const Icon(
                                    Icons.location_on,
                                    color: Colors.white,
                                  ),
                                  onPressed: () {
                                    // Request location permission and update city name
                                    widget.bloc.add(AskForLocationPermissionEvent());
                                  },
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            margin: const EdgeInsets.all(5.0),
                            height: 50.0,
                            width: double.infinity, // Take the full width within the constraints
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
                                widget.bloc.add(LoadWeatherEvent(_controller.text));
                              },
                              child: const Text('Search'),
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
      ),
    );
  }
}
