import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/networking.dart';

import 'location.dart';
import 'package:flutter/services.dart';
const apiKey = 'bc60b25202029239c778f7703abb735d';
const openWeatherMapURL = 'https://api.openweathermap.org/data/2.5/weather';
class WeatherModel {
  Future<dynamic> getCityName(String city) async{

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low);
    // latitude = position.latitude;
    // longitude = position.longitude;

    NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?q=$city&appid=$apiKey&units=metric');
    var weatherData = await networkHelper.getData();

    return weatherData;
  }

  Future<dynamic> getLocationWeather() async{

  Position position = await Geolocator.getCurrentPosition(
  desiredAccuracy: LocationAccuracy.low);
  // latitude = position.latitude;
  // longitude = position.longitude;

  NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?lat={position.latitude}&lon=${position.longitude}&appid=$apiKey&units=metric');
  var weatherData = await networkHelper.getData();

  return weatherData;
}
  String getWeatherIcon(int condition) {
    if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
