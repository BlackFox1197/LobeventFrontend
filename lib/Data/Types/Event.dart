import 'MyType.dart';

class Event extends MyType{
  final int id;
  final String name;
  final DateTime date;

  Event({this.id, this.name, this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      name: json['name'] as String,
      date: json['date'] as DateTime,
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'name' : name,
        'date' : date,
        'id'   : id
      };

}

