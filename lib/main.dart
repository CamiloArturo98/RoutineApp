import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'HomeScreen.dart';
import 'routine.dart'; // Importa el modelo de rutina

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(RoutineAdapter()); // Registra el adaptador
  await Hive.openBox<Routine>('routines'); // Abre la caja para las rutinas
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gym Routine App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}
