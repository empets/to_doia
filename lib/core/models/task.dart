class Task {
  final String id;
  String title, date, time, recurrence;
  bool done;

  Task({
    required this.id, required this.title,
    required this.date, required this.time,
    this.recurrence = 'Aucune', this.done = false,
  });

  String get dateLabel => date;
  String get timeLabel => time;
}