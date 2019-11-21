class Event {
  final int id;
  final String name;
  final String date;

  Event({this.id, this.name, this.date});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      id: json['id'] as int,
      name: json['name'] as String,
      date: json['date'] as String,
    );
  }
  Map<String, dynamic> toJson() =>
      {
        'name' : name,
        'date' : date,
        'id'   : id
      };

}

