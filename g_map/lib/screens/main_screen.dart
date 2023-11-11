import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';
//import 'package:url_launcher/url_launcher_string.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {

  String locationMessage = "Current location of the user";

  late String lat;
  late String long;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Map"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text(locationMessage),
            const SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
                onPressed: () async {
                  _getCurrentLocation().then((value) {
                    lat = '${value.latitude.toString()}';
                    long = '${value.longitude.toString()}';
                    setState(() {
                      locationMessage = 'Latitude: $lat , Longitude: $long';
                    });
                    _liveLocation();
                  }
                  );
                },
                child: Text('Get Current Location'),
            ),
            const SizedBox(
              height: 40.0,
            ),
            ElevatedButton(
              onPressed: () async {
                _getCurrentLocation().then((value) {
                  lat = '${value.latitude.toString()}';
                  long = '${value.longitude.toString()}';
                  setState(() {
                    locationMessage = 'Latitude: $lat , Longitude: $long';
                  });
                  _liveLocation();
                  _openMap(lat, long);
                }
                );
              },
              child: const Text('Open Map'),
            ),
          ],
        ),
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  void _liveLocation() {
    final LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );
    Geolocator.getPositionStream(locationSettings: locationSettings).listen(
            (Position? position) {
              lat = '${position?.latitude.toString()}';
              long = '${position?.longitude.toString()}';

              setState(() {
                locationMessage = 'Latitude: $lat , Longitude: $long';
              });

            });
  }

  Future<void> _openMap(String lat, String long) async {
    final Uri _url = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$long');

    //final Uri _url = Uri.parse('https://flutter.dev');

    // await canLaunchUrlString(googleURL)
    //     ? await launchUrlString(googleURL)
    //     : throw 'Could not launch $googleURL';


      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }

  }
}

