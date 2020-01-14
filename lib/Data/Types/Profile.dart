import 'location.dart';
import 'name.dart';
import 'picture.dart';

class Profile {
  final String gender;
  final Name name;
  final Location location;
  final String email;
  final Picture picture;

  Profile(this.gender, this.name, this.location, this.email, this.picture);

  Profile.fromJson(Map<String, dynamic> json)
      : gender = json["gender"],
        name = Name.fromJson(json["name"]),
        location = Location.fromJson(json["location"]),
        email = json["email"],
        picture = Picture.fromJson(json["picture"]);
}
