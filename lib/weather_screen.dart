import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  String _currentCity = 'Saratov';
  String _currentWeather = 'Loading...';
  final TextEditingController _cityController = TextEditingController();
  final apiKey = 'ca7442f1c14f476df9bf880ad83749f3';

  @override
  void initState() {
    super.initState();
    _fetchWeatherData(_currentCity);
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      _fetchWeatherData(_currentCity);
    });
  }

  Future<void> _fetchWeatherData(String city) async {
    final apiUrl =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final temperatureInKelvin = jsonBody['main']['temp'];
      final cityName = jsonBody['name'];
      final temperatureInCelsius = temperatureInKelvin - 273.15;
      setState(() {
        _currentCity = cityName;
        _currentWeather =
            'Temperature in $cityName: ${temperatureInCelsius.toStringAsFixed(0)}°C';
      });
    } else {
      setState(() {
        _currentWeather = 'Failed to fetch weather data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Text(
            'Weather in $_currentCity',
            style: const TextStyle(fontSize: 24),
          ),
          const SizedBox(height: 20),
          Text(
            _currentWeather,
            style: const TextStyle(fontSize: 18),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: TextField(
              controller: _cityController,
              decoration: const InputDecoration(labelText: 'Enter City'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final enteredCity = _cityController.text;
              if (enteredCity.isNotEmpty) {
                _fetchWeatherData(enteredCity);
              }
            },
            child: const Text('Get Weather'),
          ),
        ],
      ),
    );
  }
}
