
import 'package:clima_flutter/screens/location_screen.dart';
import 'package:clima_flutter/services/weather.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class LoadingScreen extends StatefulWidget {


  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {


  double latitude = 0.0;
  double longitude = 0.0;

  @override
  void initState() {


    super.initState();
    getLocationData();
    //getData();
  }
  void getLocationData() async {


    var  weatherData =await WeatherModel().getLocationWeather();
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder:
    (context){
      return LocationScreen(
        locationWeather: weatherData,
      );
    }));

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
        color: Colors.cyan,
          size: 100.0,
        ),
      ),
    );
  }


}

