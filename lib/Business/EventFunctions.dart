import 'package:lobevent/Data/Types/Event.dart';
import 'package:lobevent/Services/Communication/EventCommunicator.dart';

class EventFunctions{
  EventCommunicator communicator;
  EventFunctions(){
    communicator = new EventCommunicator();
  }


  void addEvent(Event event){
    communicator.post(event);
  }

  Future<List<Event>> getOwnedUserEvents() {
    communicator.getOwnedEvents();
  }
}