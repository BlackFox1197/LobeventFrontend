import 'package:lobevent/Data/Types/Profile.dart';
import 'package:lobevent/Services/Communication/Communication_Base.dart';
import 'package:lobevent/Services/Communication/config.dart';

class ProfileCommunicator extends Communication_Base {
  static const String URL = ApiConfig.URL + ApiConfig.profileSearchPath;

  Future<List<Profile>> searchProfile() async {
    await this.addTokenHeader();
    final requestFunction = () async {
      return await client.get(URL);
    };
    final response = await this.makeRequestAndHandleErrors(requestFunction);
    List<Profile> profiles = new List<Profile>();
    List<dynamic> intermeanList = response.data;
    profiles = intermeanList.map((i) => Profile.fromJson(i)).toList();
    return profiles;
  }
}
