import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:scheduler/models/exam.dart';
import 'package:url_launcher/url_launcher.dart';

class MapScreen extends StatefulWidget {
  final Exam exam;
  const MapScreen({super.key, required this.exam});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple[200],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.indigo[800],
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Map',
          style: TextStyle(
            color: Colors.indigo[800],
          ),
        ),
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(
                widget.exam.building.latitute,
                widget.exam.building.longitute,
              ),
              initialZoom: 15.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(
                      widget.exam.building.latitute,
                      widget.exam.building.longitute,
                    ),
                    width: 80,
                    height: 80,
                    child: Icon(
                      Icons.pin_drop,
                      color: Colors.indigo[800],
                    ),
                  )
                ],
              )
            ],
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: ElevatedButton(
              onPressed: () {
                launchGoogleMaps(
                  widget.exam.building.latitute,
                  widget.exam.building.longitute,
                );
              },
              child: const Text('Navigate to Pin'),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> launchGoogleMaps(double latitude, double longitude) async {
    final urlString =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude'; // String URL
    final uri = Uri.parse(urlString); // Convert string to Uri object
    if (await canLaunchUrl(uri)) {
      // Use Uri object with canLaunchUrl
      await launchUrl(uri); // Use Uri object with launchUrl
    } else {
      throw 'Could not launch ${uri.toString()}'; // Use Uri object in error message
    }
  }
}
