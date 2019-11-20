import 'package:lobevent/Data/Types/event.dart';

class EventResponse {
  final List<Event> results;
  final String error;

  EventResponse(this.results, this.error);

  EventResponse.fromJson(Map<String, dynamic> json)
      : results =
  (json["results"] as List).map((i) => new Event.fromJson(i)).toList(),
        error = "";

  EventResponse.withError(String errorValue)
      : results = List(),
        error = errorValue;
}