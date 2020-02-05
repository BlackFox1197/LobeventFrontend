import 'package:lobevent/Data/Types/MyType.dart';

class Event extends MyType{
  int id;
  String name;
  DateTime date;
  int userId;

  Event({this.id, this.name, this.date, this.userId});

  factory Event.fromJson(Map<String, dynamic> json) {
    final event = Event(
        id: json['id'] as int,
        name: json['name'] as String,
        date: DateTime.parse(json['date']),
        userId: json['profile']['id'] as int
    );
    return event;
  }
  Map<String, dynamic> toJson() =>
      {
        'name' : name,
        'date' : date.toIso8601String(),
        'id'   : id,
        'profile': {'id': userId}
      };

}

