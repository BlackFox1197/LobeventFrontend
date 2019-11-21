import 'event.dart';

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