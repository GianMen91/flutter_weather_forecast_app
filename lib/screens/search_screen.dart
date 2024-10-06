import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_bloc.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_event.dart';
import 'package:flutter_weather_forecast_app/bloc/weather_state.dart';

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
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
              child: Container(
            height: 300,
            width: 300,
            child: const Icon(Icons.safety_check),
          )),
          BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              // Populate the text field with the current city name if available
              if (state.currentCityName.isNotEmpty) {
                _controller.text = state.currentCityName;
              }

              return Container(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(5.0),
                      height: 50.0,
                      width: MediaQuery.of(context).size.width,
                      child: TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.search, color: Colors.black,),
                          enabledBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),

                          focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                  color: Colors.blue
                              )
                          ),

                          hintText: "City Name",
                          hintStyle: const TextStyle(color: Colors.grey),

                          labelText: 'City Name',
                          suffixIcon: IconButton(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.grey[800],
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
                      width: MediaQuery.of(context).size.width,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
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
        ]);
  }
}
