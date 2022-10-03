import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

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

  @override
  Widget build(BuildContext context) {
    String myMargin = 'abc';
    double myMarginAsDouble;
    try {
      myMarginAsDouble = double.parse(myMargin);
    }
    catch (e) {
      print(e);

    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(myMarginAsDouble = 50.0),
        color: Colors.red,
      ),
    );
  }

}