// A company using the application
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:meta/meta.dart';

class CompanyAdmin extends User {
  final String companyName;
  final String companyWebsite;
  final List<String> companyEmployeesIds;

  CompanyAdmin(
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
      @required this.companyName,
      @required this.companyWebsite,
      @required this.companyEmployeesIds})
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

  // if there is logic in entities -> write test for logic in entities!

}
