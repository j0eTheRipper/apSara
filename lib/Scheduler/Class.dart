class Class {
  final String moduleID, moduleTitle, location, tutor;
  final DateTime _start, _end;

  DateTime get start => _start;
  DateTime get end => _end;

  String get startTime {
    var time = _start.toLocal();
    return "${time.hour}:${time.minute}";
  }

  String get endTime {
    var time = _end.toLocal();
    return "${time.hour}:${time.minute}";
  }

  String get day {
    var day = _start.weekday;
    return [
      "Monday",
      "Tuesday",
      "Wednesday",
      "Thursday",
      "Friday",
      "Saturday",
      "Sunday"
    ][day - 1];
  }

  String get date {
    var timeInfo = _start;
    return "${timeInfo.day}/${timeInfo.month}/${timeInfo.year}";
  }

  const Class({
    required DateTime start,
    required DateTime end,
    required this.moduleTitle,
    required this.moduleID,
    required this.location,
    required this.tutor,
  }) : _end = end, _start = start;


  factory Class.fromJson(Map<String, dynamic> classJsonObject) {
    String timeFromISO = classJsonObject["TIME_FROM_ISO"];
    String timeToISO = classJsonObject["TIME_TO_ISO"];
    String moduleID = classJsonObject["MODID"];
    String moduleTitle = classJsonObject["MODULE_NAME"];
    String tutor = classJsonObject["NAME"];
    String location = classJsonObject["ROOM"];

    return Class(
      start: DateTime.parse(timeFromISO),
      moduleTitle: moduleTitle,
      moduleID: moduleID,
      end: DateTime.parse(timeToISO),
      location: location,
      tutor: tutor,
    );
  }
}
