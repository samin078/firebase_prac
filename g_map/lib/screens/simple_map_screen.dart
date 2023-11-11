// import 'dart:async';
//
// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
//
// class SimpleMapScreen extends StatefulWidget {
//   const SimpleMapScreen({Key? key}) : super(key: key);
//
//   @override
//   State<SimpleMapScreen> createState() => _SimpleMapScreenState();
// }
//
// class _SimpleMapScreenState extends State<SimpleMapScreen> {
//
//   final Completer<GoogleMapController> _controller = Completer();
//
//   static const CameraPosition initialPosition = CameraPosition(target: LatLng(37.15478, -122.78945),zoom: 14.0);
//
//   static const CameraPosition targetPosition = CameraPosition(target: LatLng(33.15478, -135.78945),zoom: 14.0, bearing: 192, tilt: 60);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Simple Google Map"),
//           centerTitle: true,
//       ),
//       body: GoogleMap(
//         initialCameraPosition: initialPosition,
//         mapType: MapType.normal,
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {},
//         label: Text("To the lake"),
//         icon: Icon(Icons.directions_boat),
//       ),
//     );
//   }
// }
