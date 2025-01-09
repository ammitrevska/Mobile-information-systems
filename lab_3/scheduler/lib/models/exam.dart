import 'package:scheduler/models/building.dart';

class Exam {
  final String name;
  final DateTime dateTime;
  final Building building;

  Exam({required this.name, required this.dateTime, required this.building});
}
