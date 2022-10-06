import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:weather_app/screens/city_screen.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';


class LocationScreen extends StatefulWidget {
  const LocationScreen({super.key, this.locationWeather});
  final locationWeather;

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weather = WeatherModel();

  late int temperature;
  late String  weatherIcon;
  late String weatherMessage;
  late String city;




  @override
  void initState() {
    super.initState();
    updateUI(widget.locationWeather);

  }

  void updateUI (dynamic weatherData) {
   setState(() {
     if (weatherData == null) {
       temperature= 0;
       weatherIcon= 'error';
       weatherMessage = 'unable to get data';
       city='';
       return;
     }

     double temp = weatherData['main']['temp'];
     temperature = temp.toInt();
     var condition = weatherData['weather'][0]['id'];
     weatherIcon = weather.getWeatherIcon(condition);
     weatherMessage = weather.getMessage(temperature);
     city = weatherData['name'];
   });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: const BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: () async{
                      var weatherData = await weather.getLocationWeather();
                      updateUI(weatherData);
                    },
                    child: const Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                    var typedName = await  Navigator.push(context, MaterialPageRoute(builder: (context){
                        return CityScreen();
                      },
                    ),
                    );
                   if (typedName!= null)  {
                    var weatherData= await weather.getCityName(typedName);
                    updateUI(weatherData);
                   }

                    },
                    child: const Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0),
                child: Row(
                  children:  [
                    Text(
                      '$temperature°C',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
               Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "$weatherMessage in $city",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


