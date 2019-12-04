import 'MyType.dart';

class Event extends MyType{
  final int id;
  final String name;
  final DateTime date;
  final int userId;

  Event({this.id, this.name, this.date, this.userId});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      name: json['name'] as String,
      date: json['date'] as DateTime,
      userId: json['userId'] as int
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'name' : name,
        'date' : date,
        'id'   : id,
        'userId': userId
      };

}

