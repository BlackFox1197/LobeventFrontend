import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:meta/meta.dart';

class CompanyAdminModel extends CompanyAdmin {
  CompanyAdminModel(
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
      @required String companyName,
      @required String companyWebsite,
      @required List<String> companyEmployeesIds})
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
          companyName: companyName,
          companyWebsite: companyWebsite,
          companyEmployeesIds: companyEmployeesIds,
        );

  factory CompanyAdminModel.FromCompanyAdmin(CompanyAdmin user) {
    return CompanyAdminModel(
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
      companyName: user.companyName,
      companyWebsite: user.companyWebsite,
      companyEmployeesIds: user.companyEmployeesIds,
    );
  }

  factory CompanyAdminModel.fromJson(Map<String, dynamic> json) {
    var companyEmloyeeIdsJson = json['companyEmployeesIds'];
    List<String> companyEmloyeeIds = companyEmloyeeIdsJson != null
        ? new List<String>.from(companyEmloyeeIdsJson)
        : null;

    return CompanyAdminModel(
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
      companyName: json["companyName"],
      companyWebsite: json["companyWebsite"],
      companyEmployeesIds: companyEmloyeeIds,
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
      "companyName": companyName,
      "companyWebsite": companyWebsite,
      "companyEmployeesIds": companyEmployeesIds,
    };
  }
}
