// A user of the application
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:meta/meta.dart';

class Customer extends User {
  final String solarServiceProviderId;

  Customer(
      {@required String firstname,
      @required String lastname,
      @required String id,
      @required String email,
      @required String country,
      @required String state,
      @required String postalcode,
      @required String street,
      @required String houseNumber,
      @required String phoneNumber,
      @required this.solarServiceProviderId})
      : super(
          firstname: firstname,
          lastname: lastname,
          id: id,
          email: email,
          country: country,
          state: state,
          postalcode: postalcode,
          street: street,
          houseNumber: houseNumber,
          phoneNumber: phoneNumber,
        );
}
