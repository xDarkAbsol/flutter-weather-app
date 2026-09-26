import 'package:flutter/material.dart';

class AdditionalInfo extends StatelessWidget {
  final double windSpeed,humidity,pressure;
  const AdditionalInfo({
    super.key,
    required this.humidity,
    required this.pressure,
    required this.windSpeed
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          StatColumn(
            statInfo: 'Humidity',
            statValue: humidity,
            weatherIcon: Icons.water_drop,
          ),
          StatColumn(
            statInfo: 'Wind Speed',
            statValue: windSpeed,
            weatherIcon: Icons.air,
          ),
          StatColumn(
            statInfo: 'Pressure',
            statValue: pressure,
            weatherIcon: Icons.beach_access,
          ),
        ],
      ),
    );
  }
}

class StatColumn extends StatelessWidget {
  final String statInfo;
  final double statValue;
  final IconData weatherIcon;

  const StatColumn({
    super.key,
    required this.statInfo,
    required this.statValue,
    required this.weatherIcon,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(weatherIcon, size: 45),
          Column(
            children: [
              Text(statInfo),
              Text('$statValue', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
