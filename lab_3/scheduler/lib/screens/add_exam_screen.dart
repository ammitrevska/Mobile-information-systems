import 'package:flutter/material.dart';
import 'package:scheduler/models/building.dart';
import 'package:scheduler/models/buldings_list.dart';
import 'package:scheduler/models/exam.dart';

class AddExamScreen extends StatefulWidget {
  const AddExamScreen({super.key});

  @override
  State<AddExamScreen> createState() => _AddExamScreenState();
}

class _AddExamScreenState extends State<AddExamScreen> {
  final _formKey = GlobalKey<FormState>();
  String _examName = '';
  DateTime _examDateTime = DateTime.now();
  Building? selectedBuilding;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Exam'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Exam Subject'),
                validator: (value) =>
                    value!.isEmpty ? 'Enter subject name' : null,
                onSaved: (newValue) => _examName = newValue!,
              ),
              const SizedBox(
                height: 16.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  );
                  if (date != null) {
                    final time = await showTimePicker(
                      context: context,
                      initialTime: TimeOfDay.now(),
                    );
                    if (time != null) {
                      setState(() {
                        _examDateTime = DateTime(
                          date.year,
                          date.month,
                          date.day,
                          time.hour,
                          time.minute,
                        );
                      });
                    }
                  }
                },
                child: const Text('Pick date & Time'),
              ),
              DropdownButtonFormField<Building>(
                decoration: const InputDecoration(labelText: 'Select Building'),
                items: buildings.map((building) {
                  return DropdownMenuItem<Building>(
                    value: building,
                    child: Text(building.name),
                  );
                }).toList(),
                onChanged: (value) => setState(() => selectedBuilding = value),
                validator: (value) =>
                    value == null ? 'Select a building' : null,
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    final newExam = Exam(
                      name: _examName,
                      dateTime: _examDateTime,
                      building: selectedBuilding!,
                    );
                    Navigator.pop(context, newExam);
                  }
                },
                child: const Text('Add Exam'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
