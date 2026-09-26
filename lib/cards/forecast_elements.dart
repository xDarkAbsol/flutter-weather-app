import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:practice_weather/cards/weather_util.dart';

class ForecastElements extends StatelessWidget {
  final Map<String, dynamic> data;
  const ForecastElements({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          final Map<String,dynamic> forecastData = data['list'][index + 1];
          final time = DateTime.parse(forecastData['dt_txt']);
          return ForecastCard(
            time: DateFormat.jm().format(time),
            temp: forecastData['main']['temp'].toDouble(),
            weatherText: forecastData['weather'][0]['main']
          );
        },
      ),
    );  
  }
}

class ForecastCard extends StatelessWidget {
  final String time;
  final String weatherText;
  final double temp;
  const ForecastCard({
    super.key,
    required this.time,
    required this.temp,
    required this.weatherText,
  });

  IconData get weatherIcon => WeatherUtil.getWeatherIcon(weatherText);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        height: 115,
        width: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              time, 
              style: TextStyle(fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Icon(weatherIcon, size: 35),
            Text('${(temp - 273.15).toStringAsFixed(2)}°C'),
          ],
        ),
      ),
    );
  }
}
