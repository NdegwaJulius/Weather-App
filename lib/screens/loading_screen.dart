import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/services/networking.dart';
import '../services/weather.dart';
import 'location_screen.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});


  @override
  _LoadingScreenState createState() => _LoadingScreenState();


}


class _LoadingScreenState extends State<LoadingScreen> {
  late double latitude;
  late double longitude;

  @override
  void initState() {
    super.initState();
    getLocationData();
  }


  void getLocationData() async {
  try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;

      NetworkHelper networkHelper = NetworkHelper('$openWeatherMapURL?''lat=$latitude&lon=$longitude&appid=$apiKey&units=metric');
      var weatherData = await networkHelper.getData();
      Navigator.push(context, MaterialPageRoute(builder: (context){
        return LocationScreen(locationWeather: weatherData);
      }));



      print(weatherData);
    }
        catch(e){
          print(e);
        }

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitFadingFour(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }

}