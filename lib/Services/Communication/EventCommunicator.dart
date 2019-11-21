import 'dart:convert';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/Communication_Interface.dart';
import 'package:lobevent/Services/Communication/config.dart';


///Implements Methods to communicate to the Backend
class EventCommunicator extends Communication_Base implements Communication_Interface<Event>{
  static const String URL = ApiConfig.URL + ApiConfig.eventPath;

  EventCommunicator() : super();

  /// Returns an Future of a List of all events
  /// The mapping from JSON to List of Events is done internally
  Future<List<Event>> get() async{
    final response = await client.get(URL);
    List<Event> events = new List<Event>(); //init the List
    //map the date form the decoded json to an list and call Event.fromJson for each of them
    events = json.decode(response.data).map((i) => Event.fromJson(i)).toList();
    return events;
  }

  ///Returns an single event given the id
  Future<Event> getByID(int id) async{

    final response = await client.get(URL + "/"  +id.toString()); //assembling the string in the get() parameter for getting with id
    Event event = Event.fromJson(json.decode(response.data));
    return event;
  }

  ///Posts an event to the WEB-API
  void post(Event event) async{ //TODO: implement errorHandling
    final String jsonEvent = jsonEncode(event.toJson());
    await client.post(URL, data: jsonEvent);
  }




}