import 'package:lobevent/Data/Types/event_response.dart';
import 'package:lobevent/Business/event_api_provider.dart';

class EventRepository{
  EventApiProvider _apiProvider = EventApiProvider();

  Future<EventResponse> getEvent(){
    return _apiProvider.getEvent();
  }
}