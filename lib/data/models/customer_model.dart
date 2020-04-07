import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:meta/meta.dart';

class CustomerModel extends Customer {
  CustomerModel({
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
    @required solarServiceProviderId,
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
          solarServiceProviderId: solarServiceProviderId,
        );

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
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
      solarServiceProviderId: json['solarServiceProviderId'],
    );
  }

  factory CustomerModel.FromCustomer(Customer user) {
    return CustomerModel(
      firstname: user.firstname,
      lastname: user.lastname,
      email: user.email,
      id: user.id,
      country: user.country,
      state: user.state,
      postalcode: user.postalcode,
      street: user.street,
      houseNumber: user.houseNumber,
      phoneNumber: user.phoneNumber,
      solarServiceProviderId: user.solarServiceProviderId,
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
      "solarServiceProviderId": solarServiceProviderId,
    };
  }
}
