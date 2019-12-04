import 'MyType.dart';

class Event extends MyType{
  final int id;
  final String name;
  final DateTime date;
  final int userId;

  Event({this.id, this.name, this.date, this.userId});

  factory Event.fromJson(Map<String, dynamic> json) {
    final event = Event(
        id: json['id'] as int,
        name: json['name'] as String,
        date: DateTime.parse(json['date']),
        userId: json['user']['id'] as int
    );
    return event;
  }
  Map<String, dynamic> toJson() =>
      {
        'name' : name,
        'date' : date,
        'id'   : id,
        'user': {'id': userId}
      };

}

