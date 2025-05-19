import 'package:ap_sara/Scheduler/Class.dart';

class Timetable {
  final List<Class> classes;

  const Timetable({required this.classes});

  factory Timetable.fromJson(List<dynamic> classes) {
    List<Class> classList = List.empty(growable: true);
    for (var cls in classes) {
      Class newClass = Class.fromJson(cls);
      classList.add(newClass);
    }

    return Timetable(classes: classList);
  }
}
