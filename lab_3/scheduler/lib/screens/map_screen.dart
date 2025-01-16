import 'package:flutter/material.dart';
import 'package:flutter_background_geolocation/flutter_background_geolocation.dart'
    as bg;
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
  List<bg.Geofence> _geofences = [];

  @override
  void initState() {
    super.initState();
    _loadGeofences();
  }

  // Load geofences from background geolocation
  void _loadGeofences() async {
    try {
      final geofences = await bg.BackgroundGeolocation.geofences;
      setState(() {
        _geofences = geofences;
      });
    } catch (e) {
      print("Error loading geofences: $e");
    }
  }

  // Launch Google Maps for navigation
  Future<void> launchGoogleMaps(double latitude, double longitude) async {
    final urlString =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    final uri = Uri.parse(urlString);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch ${uri.toString()}';
    }
  }

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
          // Map with markers
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
                markers: _getMarkers(),
              ),
            ],
          ),
          // Navigate to pin button
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

  // Generate markers from geofences
  List<Marker> _getMarkers() {
    return _geofences.map((geofence) {
      final latitude = geofence.latitude;
      final longitude = geofence.longitude;

      return Marker(
        point: LatLng(latitude!, longitude!),
        width: 80,
        height: 80,
        child: GestureDetector(
          onTap: () {
            // Display exam info on marker tap
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: Text(geofence.identifier),
                content: Text(
                  'Lat: $latitude, Lon: $longitude\nTime: ${widget.exam.dateTime}',
                ),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('Close'),
                  ),
                ],
              ),
            );
          },
          child: const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 40,
          ),
        ),
      );
    }).toList();
  }
}
