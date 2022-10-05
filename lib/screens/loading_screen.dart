import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}


class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }


  void getLocation() async {
    //LocationPermission permission = await Geolocator()
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low);
      print(position);
    }
        catch(e){
          print(e);
        }
  }

  void getData() async{
    http.Response  response = await http.get(Uri.parse('https://api.openweathermap.org/data/2.5/weather?lat=-4.003&lon=39.70&appid=bc60b25202029239c778f7703abb735d'));
   if (response.statusCode ==200) {
     String data = response.body;
     var decodedData = jsonDecode(data);

     double temp = decodedData['main']['temp'];
     print(temp);

     int condit = decodedData['weather'][0]['id'];
     print(condit);

     String city = decodedData['name'];
     print(city);

   } else {
     print(response.statusCode);
   }

  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold();
  }

}