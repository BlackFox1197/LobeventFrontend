import 'dart:convert';
import 'package:lobevent/Data/Types/RegistrationResponse.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/Communication_Interface.dart';
import 'package:lobevent/Services/Communication/config.dart';
import 'package:lobevent/Data/Types/User.dart';

///Implements Methods to communicate to the Backend
class RegistrationCommunicator extends Communication_Base {
  static const String URL = ApiConfig.URL + ApiConfig.registrationPath;

  RegistrationCommunicator() : super();

  Future<bool> sendRegistration(String email, String password) async {
    //Send email and password to server for registration

    new User(email, password);
    print((User(email, password)).toJson());
    final response =
        await client.post(URL, data: (User(email, password)).toJson());
    final bool success = RegistrationResponse.fromJSON(response.data).success;
    return success;
  }
}
