import 'package:hive/hive.dart';

part 'routine.g.dart';

@HiveType(typeId: 1)
class Routine {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final List<String> exercises; // Lista de ejercicios

  Routine({required this.name, required this.exercises});
}
