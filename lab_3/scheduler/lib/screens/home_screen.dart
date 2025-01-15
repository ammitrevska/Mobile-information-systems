import 'package:flutter/material.dart';
import 'package:scheduler/models/exam.dart';
import 'package:scheduler/screens/add_exam_screen.dart';
import 'package:scheduler/screens/all_events_map_screen.dart';
import 'package:scheduler/screens/map_screen.dart';
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  DateTime _selectedDate = DateTime.now();
  final List<Exam> _exams = [];

  void _navigateToAddExam() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AddExamScreen(),
      ),
    );

    if (result != null && result is Exam) {
      setState(() {
        _exams.add(result);
      });
    }
  }

  void _navigateToMap(Exam exam) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(exam: exam),
      ),
    );
  }

  void _navigateToAllEventsMap() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AllEventsMapScreen(exams: _exams),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final filteredExams = _exams
        .where((exam) => isSameDay(exam.dateTime, _selectedDate))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Exam Scheduler'),
        actions: [
          IconButton(
            onPressed: () => _navigateToAllEventsMap(),
            icon: const Icon(Icons.map),
          ),
          IconButton.filled(
            onPressed: () => _navigateToAddExam(),
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TableCalendar(
            focusedDay: _selectedDate,
            firstDay: DateTime.utc(2010),
            lastDay: DateTime.utc(2030),
            calendarFormat: CalendarFormat.month,
            selectedDayPredicate: (day) => isSameDay(day, _selectedDate),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDate = selectedDay;
              });
            },
          ),
          Expanded(
            child: filteredExams.isEmpty
                ? const Center(
                    child: Text('No exams scheduled for this date'),
                  )
                : ListView.builder(
                    itemCount: filteredExams.length,
                    itemBuilder: (context, index) {
                      final exam = filteredExams[index];
                      return Card(
                        child: ListTile(
                          title: Text(exam.name),
                          subtitle: Text(
                              '${exam.dateTime.hour}:${exam.dateTime.minute}, ${exam.building.name}'),
                          trailing: IconButton(
                            onPressed: () => _navigateToMap(exam),
                            icon: const Icon(
                              Icons.location_on,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          )
        ],
      ),
    );
  }
}
