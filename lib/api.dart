import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather/model.dart'; // Ensure this contains the Whether model
import 'package:http/http.dart' as http;

class FetchData extends ChangeNotifier {
  String? city;
  String? temperature;
  String? condition;
  String? location;
  String? windSpeed;

  Future<Whether?> fetchApi(String location) async {

    print("Fetching data for location: $location");
    try {
      final response = await http.get(Uri.parse(
          'https://api.openweathermap.org/data/2.5/weather?q=$location&appid=218ebbb372884cecfd15fecc029d35cb&units=metric'));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return Whether.fromJson(data);
      } else {
        print("Error fetching API: ${response.statusCode}");
      }
    } catch (e) {
      print("Exception: $e");
    }
    return null;
  }

  Future<void> displayData(String locationData) async {
    location = locationData; 
    final weatherData = await fetchApi(locationData);
    if (weatherData != null) {
      city = weatherData.cityName;
      temperature = weatherData.temeprature;
      condition = weatherData.contition;
      windSpeed = weatherData.wind;

      print("City: $city, Temperature: $temperature°C, Condition: $condition");
      notifyListeners(); 
    } else {
      print("Failed to fetch weather data.");
    }
  }
}
