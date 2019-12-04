import 'package:lobevent/Data/Types/UserEventStatus.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';
import 'package:lobevent/Services/Communication/UserEventStatusCommunicator.dart';

class EventResponseFunctions {

  UserEventStatusCommunicator communicator;
  EventFunctions(){
    this.communicator = new UserEventStatusCommunicator();
  }

  ///generates UserEventStatus response
  ///$response should be between 0 and 2 where 0 is accept, 1 is deny, 2 is interested
  void sendEventResponse(int response, int eventId){
    UserEventStatus userEventStatus = UserEventStatus();
    userEventStatus.eventId = eventId;
    userEventStatus.status = response;
    communicator.post(userEventStatus);
  }
}