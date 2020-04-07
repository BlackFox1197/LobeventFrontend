import 'package:auditergy_flutter/ui/pages/login/widgets/register_radiobuttons.dart';
import 'package:dartz/dartz_unsafe.dart';
import 'package:flutter/material.dart';

class RegisterFieldControllers {
  static final firstNameController = TextEditingController();
  static final lastNameController = TextEditingController();
  static final streetController = TextEditingController();
  static final houseNumberController = TextEditingController();
  static final stateController = TextEditingController();
  static final postalCodeController = TextEditingController();
  static final countryController = TextEditingController();
  static final companyController = TextEditingController();
  static final phoneNumberController = TextEditingController();

  static final companyNameController = TextEditingController();
  static final companyWebsiteController = TextEditingController();

  static final emailController = TextEditingController();
  static final passwordController = TextEditingController();
  static final confirmPasswordController = TextEditingController();

  static final registerFieldsControllers = [
    firstNameController,
    lastNameController,
    streetController,
    houseNumberController,
    stateController,
    postalCodeController,
    countryController,
    companyController,
    phoneNumberController,
    companyNameController,
    companyWebsiteController,
    emailController,
    passwordController,
    confirmPasswordController
  ];

  var nameControllerList = [
    firstNameController,
    lastNameController,
    streetController,
    stateController,
    countryController,
    companyController,
    companyNameController
  ];

  static final companyAdminControllerList = [
    firstNameController,
    lastNameController,
    phoneNumberController,
    streetController,
    houseNumberController,
    stateController,
    postalCodeController,
    countryController,
    companyNameController,
    companyWebsiteController,
    emailController,
    passwordController,
    confirmPasswordController
  ];

  static final customerControllerList = [
    firstNameController,
    lastNameController,
    phoneNumberController,
    streetController,
    houseNumberController,
    stateController,
    postalCodeController,
    countryController,
    companyController,
    emailController,
    passwordController,
    confirmPasswordController
  ];

  var passwordControllerList = [passwordController, confirmPasswordController];

  static void clearFields() {
    registerFieldsControllers.forEach((controller) => controller.clear());
  }

  static bool checkFieldsFilled(Rolls role) {
    bool allFilled = true;
    if (role == Rolls.CompanyAdmin) {
      companyAdminControllerList.forEach((c) {
        if (!RegExp(r"\S").hasMatch(c.text)) {
          allFilled = false;
        }
      });
    } else if (role == Rolls.Customer) {
      customerControllerList.forEach((c) {
        if (!RegExp(r"\S").hasMatch(c.text)) {
          print(c.text);
          allFilled = false;
        }
      });
    }
    return allFilled;
  }

  bool checkInputs() {
    bool res = true;
    // no numbers and special signs for any kind of names
    nameControllerList.every((TextEditingController controller) {
      if (RegExp(r"^[a-zA-ZäöüÄÖÜ]+(([',. -][a-zA-ZäöüÄÖÜ ])?[a-zA-ZäöüÄÖÜ]*)*$")
              .hasMatch(controller.text) ==
          false) {
        print(controller.text + ' is invalid');
        res = false;
      }
      return res;
    });

    // no leading or tailing whitespace for passwords
    passwordControllerList.every((TextEditingController controller) {
      if (RegExp(r"^[\S].*[\S]$").hasMatch(controller.text) == false) {
        print(controller.text + ' is invalid');
        res = false;
      }
      return res;
    });
    // check if passwords matching
    if (passwordControllerList[0].text != passwordControllerList[1].text) {
      print('passwords do not match');
      res = false;
    }
    // checks if housenumber starts not with "0" and max one letter at the end
    if (RegExp(r"^[1-9]+[0-9]*[a-zA-Z]?$")
            .hasMatch(houseNumberController.text) ==
        false) {
      print('housenumber \"' + houseNumberController.text + '\" is invalid');
      res = false;
    }
    // checks postalcode - nearly impossible to do full check for all valid postalcodes
    if (RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$")
            .hasMatch(postalCodeController.text) ==
        false) {
      print('postalcode \"' + postalCodeController.text + '\" is invalid');
      res = false;
    }
    // checks phoneNumer
    if (RegExp(r"^[+]?[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$")
            .hasMatch(phoneNumberController.text) ==
        false) {
      print('phoneNumber \"' + phoneNumberController.text + '\" is invalid');
      res = false;
    }
    // checks email
    if (RegExp(r"^[a-zA-Z0-9.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$")
            .hasMatch(emailController.text) ==
        false) {
      print('email \"' + emailController.text + '\" is invalid');
      res = false;
    }
    // check website
    if (RegExp(r"^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$")
            .hasMatch(companyWebsiteController.text) ==
        false) {
      print('website \"' + companyWebsiteController.text + '\" ist invalid');
      res = false;
    }
    return res;
  }
}
