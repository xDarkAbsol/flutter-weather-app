import 'package:flutter/material.dart';
import 'dart:ui';

import 'package:practice_weather/cards/weather_util.dart';

class MainCard extends StatelessWidget {
  final double temp;
  final String weatherText;
  const MainCard({
    super.key,
    required this.temp,
    required this.weatherText,
  }); 

  IconData get weatherIcon => WeatherUtil.getWeatherIcon(weatherText);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    '${(temp - 273.15).toStringAsFixed(2)}°C',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 32
                    ),
                  ),
                  Icon(weatherIcon, size: 80),
                  Text(
                    weatherText,
                    style: TextStyle(
                      fontSize: 20
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}