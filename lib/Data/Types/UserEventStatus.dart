import 'package:lobevent/Data/Types/MyType.dart';

//Status, userid, eventid

class UserEventStatus extends MyType {
  int status;
  int userId;
  int eventId;

  UserEventStatus({this.status, this.userId, this.eventId});

  factory UserEventStatus.fromJson(Map<String, dynamic> json) {
    return UserEventStatus(
      status: json['status'] as int,
      userId: json['user']['id'] as int,
      eventId: json['event']['id'] as int,
    );
  }
  Map<String, dynamic> toJson() => {
        'status': status,
        'user': {'id': userId},
        'event': {'id': eventId},
      };
}
