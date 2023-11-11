import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kuch Bhi'),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(22.8994026, 89.5018501),
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.app',
              ),
              // PolygonLayer(
              //   polygons: [
              //     Polygon(
              //       points: [
              //         LatLng(24, 91),
              //         LatLng(24, 88),
              //         LatLng(21.5, 88),
              //         LatLng(21.5, 91),
              //       ],
              //       color: Colors.blue.withOpacity(0.4),
              //       borderStrokeWidth: 2,
              //       borderColor:  Colors.blue.withOpacity(0.5),
              //       isFilled: true,
              //     ),
              //   ],
              // ),
              CircleLayer(
                circles: [
                  CircleMarker(
                    point: LatLng(22.8994026, 89.5018501),
                    color: Colors.blue.withOpacity(0.4),
                    borderStrokeWidth: 2,
                    borderColor:  Colors.blue.withOpacity(0.5),
                    radius: 5000,
                    useRadiusInMeter: true,
                  ),
                ],
              ),
              // MarkerLayer(
              //   markers: [
              //     Marker(
              //       point: LatLng(30, 40),
              //       width: 80,
              //       height: 80,
              //       child: FlutterLogo(),
              //     ),
              //   ],
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
