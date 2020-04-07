import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:meta/meta.dart';

class CompanyEmployeeModel extends CompanyEmployee {
  CompanyEmployeeModel({
    @required String firstname,
    @required String lastname,
    @required String id,
    @required String email,
    @required String country,
    @required String state,
    @required String postalcode,
    @required String street,
    @required String houseNumber,
    @required String phoneNumber,
    @required String companyId,
  }) : super(
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
          companyId: companyId,
        );

  factory CompanyEmployeeModel.FromCompanyEmployee(CompanyEmployee user) {
    return CompanyEmployeeModel(
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
      companyId: user.companyId,
    );
  }

  factory CompanyEmployeeModel.fromJson(Map<String, dynamic> json) {
    return CompanyEmployeeModel(
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
      companyId: json['companyId'],
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
      "companyId": companyId,
    };
  }
}
