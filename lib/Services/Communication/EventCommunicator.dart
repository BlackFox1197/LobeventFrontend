import 'dart:convert';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/Communication_Interface.dart';
import 'package:lobevent/Services/Communication/config.dart';

///Implements Methods to communicate to the Backend
class EventCommunicator extends Communication_Base
    implements Communication_Interface<Event> {
  static const String URL = ApiConfig.URL + ApiConfig.eventPath;
  static const String USERURL = ApiConfig.URL + ApiConfig.userEvents;

  EventCommunicator() : super();

  /// Returns an Future of a List of all events
  /// The mapping from JSON to List of Events is done internally
  Future<List<Event>> get() async {
    await this.addTokenHeader();
    final requestFunction = () async {return await client.get(URL);};
    final response = await this.makeRequestAndHandleErrors(requestFunction);
    List<Event> events = new List<Event>(); //init the List
    List<dynamic> intermeanList = response.data;
    events = intermeanList.map((i) => Event.fromJson(i)).toList();
    //map the date form the decoded json to an list and call Event.fromJson for each of them
    return events;
  }

  ///Returns an single event given the id
  Future<Event> getByID(int id) async {
    await this.addTokenHeader();
    final requestFunction = () async {
      return await client.get(URL +
        "/" + //assembling the string in the get() parameter for getting with id
        id.toString());
    };
    final response = await this.makeRequestAndHandleErrors(requestFunction);
    Event event = Event.fromJson(response.data);
    return event;
  }

  ///Posts an event to the WEB-API
  void post(Event event) async {
    await this.addTokenHeader();
    //TODO: implement errorHandling
    event.userId = 1;
    final String jsonEvent = jsonEncode(event.toJson());
    final requestFunction = () async {return await client.post(URL, data: jsonEvent);};
    await this.makeRequestAndHandleErrors(requestFunction);
  }

  ///returns an Future of an List of events that are owned by the user-
  Future<List<Event>> getOwnedEvents() async {
    await this.addTokenHeader();


    final requestFunction = () async {await client.get(USERURL);};
    final response = await this.makeRequestAndHandleErrors(requestFunction);


    List<Event> events = new List<Event>(); //init the List
    List<dynamic> intermeanList = response.data;
    events = intermeanList.map((i) => Event.fromJson(i)).toList();
    //map the date form the decoded json to an list and call Event.fromJson for each of them
    return events;
  }

  ///sends an delete Request to the server
  void delete(int id) async {
    await this.addTokenHeader();
    final requestFunction = await () async {client.delete(URL + "/" + id.toString());};
    await this.makeRequestAndHandleErrors(requestFunction);
  }
}
