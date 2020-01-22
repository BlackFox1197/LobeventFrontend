import 'package:lobevent/Services/Communication/RegistrationCommunicator.dart';
import 'package:lobevent/Services/Storage/LoginStorage.dart';

class UserFunctions{
  static void logout(){
    LoginStorage storage = new LoginStorage();
    storage.deleteToken();
  }

  static void register(String email, String password){
    RegistrationCommunicator regCom = new RegistrationCommunicator();
    regCom.sendRegistration(email, password);
  }
}