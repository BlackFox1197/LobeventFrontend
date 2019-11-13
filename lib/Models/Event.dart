class EventsList {
  final List<Event> events;

  EventsList(
    this.events,
  );

  factory EventsList.fromJson(List<dynamic> parsedJson) {
    List<Event> events = new List<Event>();
    events = parsedJson.map((i) => Event.fromJson(i)).toList();

    return new EventsList(events);
  }
}
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

}
