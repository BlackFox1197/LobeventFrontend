//Status, userid, eventid
import 'package:lobevent/Data/Types/MyType.dart';
import 'package:lobevent/Data/Types/User.dart';

class UserEventStatus extends MyType {
  final int status;
  final String userId;
  final String eventId;

  UserEventStatus({this.status, this.userId, this.eventId});

  factory UserEventStatus.fromJson(Map<String, dynamic> json) {
    return UserEventStatus(
      status: json['status'] as int,
      userId: json['userId'] as String,
      eventId: json['eventId'] as String,
    );
  }
  Map<String, dynamic> toJson() => {
        'status': status,
        'userId': userId,
        'eventId': eventId,
      };
}
