import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/company_employee.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';

class EditedUser {
  String firstname;
  String lastname;
  String id;
  String email;
  //adress components
  String country;
  String state;
  String postalcode;
  String street;
  String houseNumber;
  String phoneNumber;

  EditedUser(
      {this.firstname,
      this.lastname,
      this.id,
      this.email,
      this.country,
      this.state,
      this.postalcode,
      this.street,
      this.houseNumber,
      this.phoneNumber});
}

class EditedCompanyAdmin extends EditedUser {
  String companyName;
  String companyWebsite;
  List<String> companyEmployeesIds;

  EditedCompanyAdmin(
      {String firstname,
      String lastname,
      String id,
      String email,
      String country,
      String state,
      String postalcode,
      String street,
      String houseNumber,
      String phoneNumber,
      this.companyName,
      this.companyWebsite,
      this.companyEmployeesIds});

  void FromCA(CompanyAdmin ca) {
    this.firstname = ca.firstname;
    this.lastname = ca.lastname;
    this.id = ca.id;
    this.email = ca.email;
    this.country = ca.country;
    this.state = ca.state;
    this.postalcode = ca.postalcode;
    this.street = ca.street;
    this.houseNumber = ca.houseNumber;
    this.phoneNumber = ca.phoneNumber;
    this.companyName = ca.companyName;
    this.companyWebsite = ca.companyWebsite;
    this.companyEmployeesIds = ca.companyEmployeesIds;
  }
  // if there is logic in entities -> write test for logic in entities!

}

class EditedCompanyEmployee extends EditedUser {
  String companyId;

  EditedCompanyEmployee({
    String firstname,
    String lastname,
    String id,
    String email,
    String country,
    String state,
    String postalcode,
    String street,
    String houseNumber,
    String phoneNumber,
    this.companyId,
  });

  void FromCE(CompanyEmployee ce) {
    this.firstname = ce.firstname;
    this.lastname = ce.lastname;
    this.id = ce.id;
    this.email = ce.email;
    this.country = ce.country;
    this.state = ce.state;
    this.postalcode = ce.postalcode;
    this.street = ce.street;
    this.houseNumber = ce.houseNumber;
    this.phoneNumber = ce.phoneNumber;
    this.companyId = ce.companyId;
  }
}

class EditedCustomer extends EditedUser {
  String solarServiceProviderId;

  EditedCustomer(
      {String firstname,
      String lastname,
      String id,
      String email,
      String country,
      String state,
      String postalcode,
      String street,
      String houseNumber,
      String phoneNumber,
      this.solarServiceProviderId});

  void FromC(Customer c) {
    this.firstname = c.firstname;
    this.lastname = c.lastname;
    this.id = c.id;
    this.email = c.email;
    this.country = c.country;
    this.state = c.state;
    this.postalcode = c.postalcode;
    this.street = c.street;
    this.houseNumber = c.houseNumber;
    this.phoneNumber = c.phoneNumber;
    this.solarServiceProviderId = c.solarServiceProviderId;
  }
}
