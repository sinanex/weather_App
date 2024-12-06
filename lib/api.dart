import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:weather/model.dart';
import 'package:http/http.dart' as http;

class FetchData extends ChangeNotifier {
  String? city;
  String? temperature;
  String? condition;
  String? location;
  String? windSpeed;
  String? mintemp;
  String? maxtemp;
  String? selectedImage;
  String? feelLike;
  bool isDataFetch = true;
  String? pressure;
  String? humidty;
  String? sunRise;
  String? sunSet;
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
        isDataFetch = false;
      }
    } catch (e) {
      print("Exception: $e");
    }
    return null;
  }

  Future displayData(String locationData) async {
    location = locationData;

    final weatherData = await fetchApi(locationData);
    if (weatherData != null) {
      sunSet = weatherData.sunSet;
      sunRise = weatherData.sunRise;
      city = weatherData.cityName;
      temperature = weatherData.temeprature;
      condition = weatherData.contition;
      windSpeed = weatherData.wind;
      maxtemp = weatherData.maxtemp;
      feelLike = weatherData.feelLike;
      mintemp = weatherData.mintemp;
      humidty = weatherData.humidity;
      pressure = weatherData.pressure;
      switch (condition) {
        case "Thunderstorm":
          selectedImage = images[8];
          print("thunder");
          break;
        case "Rain":
          selectedImage = images[6];
          print("rain");
          break;
        case "Clear":
          selectedImage = images[0];
          print("clear");
          break;
        case "Mist":
          selectedImage = images[4];
          print("mist");
          break;
        case "Clouds":
          selectedImage = images[1];
          print("Cloud");
          break;
        default:
          selectedImage = images[7];
          print("defualt");
          break;
      }
      print("City: $city, Temperature: $temperature°C, Condition: $condition");
      notifyListeners();
    } else {
      print("Failed to fetch weather data.");
      return Text("search frist");
    }
  }

  List<String> images = [
    'assets/images/clear-sky.png',
    'assets/images/clouds.png',
    'assets/images/drizzle.png',
    'assets/images/heavy-rain.png',
    'assets/images/mist.png',
    'assets/images/over.png',
    'assets/images/rain.png',
    'assets/images/snow.png',
    'assets/images/thunder.png',
  ];

  void imageChange() {
    notifyListeners();
  }
}
