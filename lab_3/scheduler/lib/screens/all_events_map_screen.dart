import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:scheduler/models/exam.dart';

class AllEventsMapScreen extends StatelessWidget {
  final List<Exam> exams;
  final PopupController _popupController = PopupController();

  AllEventsMapScreen({super.key, required this.exams});

  @override
  Widget build(BuildContext context) {
    final markers = exams.map((exam) {
      final marker = Marker(
        point: LatLng(
          exam.building.latitute,
          exam.building.longitute,
        ),
        width: 80,
        height: 80,
        child: const Icon(
          Icons.location_on,
          size: 30,
          color: Colors.red,
        ),
      );
      return marker;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('All Exam Locations'),
      ),
      body: FlutterMap(
        options: MapOptions(
          initialCenter: exams.isNotEmpty
              ? LatLng(exams[0].building.latitute, exams[0].building.longitute)
              : const LatLng(0, 0),
          initialZoom: 17.0,
        ),
        children: [
          TileLayer(
            urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          ),
          MarkerLayer(markers: markers),
          PopupMarkerLayer(
            options: PopupMarkerLayerOptions(
              popupController: _popupController,
              markers: markers,
              selectedMarkerBuilder: (context, marker) {
                final exam = exams.firstWhere((exam) =>
                    exam.building.latitute == marker.point.latitude &&
                    exam.building.longitute == marker.point.longitude);
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          exam.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text('${exam.dateTime.hour}:${exam.dateTime.minute}'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
