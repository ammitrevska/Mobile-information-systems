import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:scheduler/models/exam.dart';

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
        ],
      ),
    );
  }
}
