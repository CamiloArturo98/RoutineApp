import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'routine.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _routineNameController = TextEditingController();
  final _exerciseController = TextEditingController();
  List<String> exercises = [];

  void addRoutine() {
    final String name = _routineNameController.text;
    if (name.isNotEmpty && exercises.isNotEmpty) {
      final box = Hive.box<Routine>('routines');
      final routine = Routine(name: name, exercises: exercises);
      box.add(routine);
      _routineNameController.clear();
      exercises.clear();
      setState(() {});
    }
  }

  void addExercise() {
    final String exercise = _exerciseController.text;
    if (exercise.isNotEmpty) {
      exercises.add(exercise);
      _exerciseController.clear();
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Gym Routines'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _routineNameController,
              decoration: InputDecoration(labelText: 'Routine Name'),
            ),
            TextField(
              controller: _exerciseController,
              decoration: InputDecoration(labelText: 'Exercise'),
            ),
            ElevatedButton(
              onPressed: addExercise,
              child: Text('Add Exercise'),
            ),
            Text('Exercises:'),
            for (var exercise in exercises) Text(exercise),
            ElevatedButton(
              onPressed: addRoutine,
              child: Text('Save Routine'),
            ),
            Expanded(
              child: ValueListenableBuilder(
                valueListenable: Hive.box<Routine>('routines').listenable(),
                builder: (context, Box<Routine> box, _) {
                  if (box.isEmpty) {
                    return Center(child: Text('No routines added.'));
                  }
                  return ListView.builder(
                    itemCount: box.length,
                    itemBuilder: (context, index) {
                      final routine = box.getAt(index);
                      return ListTile(
                        title: Text(routine!.name),
                        subtitle: Text(routine.exercises.join(', ')),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
