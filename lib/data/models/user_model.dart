import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:meta/meta.dart';

class UserModel extends User {
  UserModel({
    @required firstname,
    @required lastname,
    @required email,
    @required id,
    @required country,
    @required state,
    @required postalcode,
    @required street,
    @required houseNumber,
    @required phoneNumber,
  }) : super(
          firstname: firstname,
          lastname: lastname,
          email: email,
          id: id,
          country: country,
          state: state,
          postalcode: postalcode,
          street: street,
          houseNumber: houseNumber,
          phoneNumber: phoneNumber,
        );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      firstname: json['firstname'],
      lastname: json['lastname'],
      email: json['email'],
      id: json['id'],
      country: json['country'],
      state: json['state'],
      postalcode: json['postalcode'],
      street: json['street'],
      houseNumber: json['houseNumber'],
      phoneNumber: json['phoneNumber'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "firstname": firstname,
      "lastname": lastname,
      "email": email,
      "id": id,
      "country": country,
      "state": state,
      "postalcode": postalcode,
      "street": street,
      "houseNumber": houseNumber,
      "phoneNumber": phoneNumber,
    };
  }
}
