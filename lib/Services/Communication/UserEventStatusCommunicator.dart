import 'dart:convert';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Data/Types/UserEventStatus.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/Communication_Interface.dart';
import 'package:lobevent/Services/Communication/config.dart';

class UserEventStatusCommunicator extends Communication_Base
    implements Communication_Interface<UserEventStatus> {
  static const String URL =
      ApiConfig.URL + ApiConfig.userEventStatusPath;

  UserEventStatusCommunicator() : super();

  /// Returns an Future of a List of all UserEventStatus
  /// The mapping from JSON to List of Events is done internally
  Future<List<UserEventStatus>> get() async {
    await this.addTokenHeader();
    
    final requestFunction = () async {return await client.get(URL);};
    final response = await this.makeRequestAndHandleErrors(requestFunction);

    
    List<UserEventStatus> userEventStati =
        new List<UserEventStatus>(); //init the List
    //map the date form the decoded json to an list and call Event.fromJson for each of them
    userEventStati =
        json.decode(response.data).map((i) => Event.fromJson(i)).toList();
    return userEventStati;
  }

  ///returns an list of events that could be interesting for the user
  Future<List<Event>> getEventsOfInterrest() async {
    await this.addTokenHeader();
    
    final requestFunction = () async {return await client.get(URL);};
    final response = await this.makeRequestAndHandleErrors(requestFunction);

    
    //init the List
    //map the date form the decoded json to an list and call Event.fromJson for each of them
    List<Event> events = new List<Event>(); //init the List
    List<dynamic> intermeanList = response.data;
    events = intermeanList.map((i) => Event.fromJson(i)).toList();
    return events;
  }

  ///returns an single event given the id
  Future<UserEventStatus> getByID(int id) async {
    await this.addTokenHeader();
    
    final requestFunction = () async {return await client.get(URL +
        "/" +
        id.toString());}; //assembling the string in the get() parameter for getting with id
    final response = await this.makeRequestAndHandleErrors(requestFunction);

    


    UserEventStatus userEventStatus =
        UserEventStatus.fromJson(json.decode(response.data));
    return userEventStatus;
  }

  ///Posts an event to the WEB-API
  ///[userEventStatus] is an instance of UserEventStatus
  void post(UserEventStatus userEventStatus) async {
    await this.addTokenHeader();
    //TODO: implement errorHandling
    final String jsonEvent = jsonEncode(userEventStatus.toJson());
    final requestFunction = () async {return await client.post(URL, data: jsonEvent);};
    final response = await this.makeRequestAndHandleErrors(requestFunction);

    
  }
}
