import 'package:flutter/material.dart';

class WeatherUtil {
  static IconData getWeatherIcon(String condition) {
    switch(condition) {
      case 'Rain':
        return Icons.cloudy_snowing;
      case 'Clouds':
        return Icons.cloud;
      case 'Clear':
        return Icons.sunny;
      default:
        return Icons.help_outline;
    }
  }
}