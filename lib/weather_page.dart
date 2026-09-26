import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:practice_weather/additional_info.dart';
import 'package:practice_weather/cards/forecast_elements.dart';
import 'package:practice_weather/cards/main_card.dart';
import 'package:practice_weather/secrets.dart';
import 'package:http/http.dart' as http;

class WeatherPage extends StatefulWidget{
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  late Future<Map<String,dynamic>> weatherapi = getWeather();
  double temp = 0;

  Future<Map<String,dynamic>> getWeather() async{
    try {
      final url = Uri.parse('https://api.openweathermap.org/data/2.5/forecast?q=$cityName&APPID=$apiKey');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      }
      throw 'An Unexpected Error has Occured!';
    }
    catch (e) {
      throw e.toString();
    }
  }

  @override
  void initState() {
    super.initState();
    weatherapi = getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Weather',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(onPressed:() {
            setState(() {
              weatherapi = getWeather();
            });
          }, icon: const Icon(Icons.refresh)),
        ],
      ),
      body: FutureBuilder(
        future: weatherapi,
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator.adaptive());
          }
          if (asyncSnapshot.hasError) {
            return Center(child: Text('An Unexpected Error has Occured!'));
          }
          final data = asyncSnapshot.data;
          final double temp = data!['list'][0]['main']['temp'];
          final String weather = data['list'][0]['weather'][0]['main'];
          final double currentWindSpeed = data['list'][0]['wind']['speed'];
          final int currentHumidity = data['list'][0]['main']['humidity'];
          final int currentPressure = data['list'][0]['main']['pressure'];

          return Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Main Card
                MainCard(temp: temp, weatherText: weather),
                const SizedBox(height: 20),
                // Forecast Cards
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 8),
                ForecastElements(data: data),
                const SizedBox(height: 20),
                // Addition Stats
                const Text(
                  'Additional Information',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
                const SizedBox(height: 8),
                AdditionalInfo(
                  windSpeed: currentWindSpeed,
                  pressure:  currentPressure.toDouble(),
                  humidity:  currentHumidity.toDouble()
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
