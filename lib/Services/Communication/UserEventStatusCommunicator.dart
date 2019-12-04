import 'dart:convert';
import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Data/Types/User.dart';
import 'package:lobevent/Data/Types/UserEventStatus.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/Communication_Interface.dart';
import 'package:lobevent/Services/Communication/config.dart';

class UserEventStatusCommunicator extends Communication_Base
    implements Communication_Interface<UserEventStatus> {
  static const String URL = ApiConfig.URL + ApiConfig.eventPath + "/1";

  UserEventStatusCommunicator() : super();

  /// Returns an Future of a List of all UserEventStatus
  /// The mapping from JSON to List of Events is done internally

  Future<List<UserEventStatus>> get() async {
    final response = await client.get(URL);
    List<UserEventStatus> userEventStati = new List<UserEventStatus>(); //init the List
    //map the date form the decoded json to an list and call Event.fromJson for each of them
    userEventStati = json.decode(response.data).map((i) => Event.fromJson(i)).toList();
    return userEventStati;
  }


  ///returns an single event given the id
  Future<UserEventStatus> getByID(int id) async {
    final response = await client.get(URL +
        "/" +
        id.toString()); //assembling the string in the get() parameter for getting with id
    UserEventStatus userEventStatus = UserEventStatus.fromJson(json.decode(response.data));
    return userEventStatus;
  }



  ///Posts an event to the WEB-API
  void post(UserEventStatus userEventStatus) async {
    //TODO: implement errorHandling
    final String jsonEvent = jsonEncode(userEventStatus.toJson());
    await client.post(URL, data: jsonEvent);
  }
}
