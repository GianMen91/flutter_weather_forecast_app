import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_weather_forecast_app/widgets/weather_image_widget.dart';
import 'package:intl/intl.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../models/weather.dart';

class NextDaysForecastWidget extends StatelessWidget {
  const NextDaysForecastWidget({
    super.key,
    required this.weatherForecast,
  });

  final Weather weatherForecast;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        // Dispatch an event to update the selected date
        BlocProvider.of<WeatherBloc>(context)
            .add(UpdateSelectedDateEvent(weatherForecast.date));
      },
      child: Container(
        width: size.width > 600 ? 200 : 100,
        margin: const EdgeInsets.symmetric(horizontal: 8.0),
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.3),
          // White background with 50% opacity
          // Removed border to eliminate the black outline
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              DateFormat('EEE').format(DateTime.parse(weatherForecast.date)),
              style:  TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: size.width > 600 ? 23 : 15,
              ),
            ),
            const SizedBox(height: 10),
            WeatherImageWidget(
                weatherConditionName: weatherForecast.weatherCondition.name),
            const SizedBox(height: 10),
            Text(
              '${weatherForecast.tempMin.toInt()}° / ${weatherForecast.tempMax.toInt()}°',
              style: TextStyle(color: Colors.white,fontSize: size.width > 600 ? 23 : 15),
            ),
          ],
        ),
      ),
    );
  }
}
