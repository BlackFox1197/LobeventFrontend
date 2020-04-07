import 'package:auditergy_flutter/domain/entities/company_admin.dart';
import 'package:auditergy_flutter/domain/entities/customer.dart';
import 'package:auditergy_flutter/domain/entities/user.dart';
import 'package:auditergy_flutter/ui/bloc/user/user_bloc.dart';
import 'package:auditergy_flutter/ui/pages/login/utils/registerfield_controllers.dart';
import 'package:auditergy_flutter/ui/pages/login/widgets/register_radiobuttons.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:auditergy_flutter/ui/widgets/default_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForm extends StatefulWidget {
  final BuildContext context;
  RegisterForm(this.context);

  @override
  _RegisterForm createState() => _RegisterForm(context);
}

class _RegisterForm extends State<RegisterForm> {
  _RegisterForm(BuildContext context);
  UserLoginBloc _UserLoginBloc;

  Rolls _role = Rolls.CompanyAdmin;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final registerButton = Container(
      width: MediaQuery.of(context).size.width / 4,
      height: 48,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24.0),
        ),
        elevation: 2.0,
        onPressed: () {
          regButtonPress();
        },
        padding: EdgeInsets.all(12),
        color: ColorConstants.auditergyHighlight,
        child: Text('Register',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    final confirmSuccessfulRegisterButton = Container(
      width: 144,
      height: 48,
      margin: EdgeInsets.all(12),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 2.0,
        onPressed: () {
          confirmRegisterPress();
        },
        padding: EdgeInsets.all(12),
        color: ColorConstants.auditergyHighlight,
        child: Text('OK',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return BlocBuilder<UserLoginBloc, UserLoginState>(
      bloc: _UserLoginBloc,
      builder: (context, state) {
        if (state is UserRegisterLoadingState) {
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              child: Text("loading"),
            ),
          );
        } else if (state is UserRegisteredState) {
          return Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(24),
                    child: Text(
                      "Successfully registered, please check your emails.",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  confirmSuccessfulRegisterButton,
                ],
              ));
        } else if (state is RegisterCompanyAdminState ||
            state is RegisterCustomerState) {
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 24, right: 24),
                  width: MediaQuery.of(context).size.width * 0.66,
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        SizedBox(height: 16.0),
                        RegisterRadioButtons(callParent: (Rolls value) {
                          dispatchRolechangingEvent(value);
                        }),
                        // Names
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: DefaultTextField(
                                    TextInputType.text,
                                    'First Name',
                                    false,
                                    RegisterFieldControllers
                                        .firstNameController),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: DefaultTextField(
                                    TextInputType.text,
                                    'Last Name',
                                    false,
                                    RegisterFieldControllers
                                        .lastNameController),
                              ),
                            ]),
                        SizedBox(height: 4.0),
                        DefaultTextField(
                            TextInputType.phone,
                            'Phone number',
                            false,
                            RegisterFieldControllers.phoneNumberController),
                        SizedBox(height: 4),
                        Container(
                          height: 24,
                          padding: EdgeInsets.only(top: 4),
                          child: new Text(getAddressText(state),
                              textAlign: TextAlign.center,
                              style: new TextStyle(
                                  fontSize: 16,
                                  decoration: TextDecoration.underline)),
                        ),
                        // Street
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(bottom: 4),
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: DefaultTextField(
                                    TextInputType.text,
                                    'Street',
                                    false,
                                    RegisterFieldControllers.streetController),
                              ),
                              Container(
                                margin: EdgeInsets.only(bottom: 4),
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: DefaultTextField(
                                    TextInputType.number,
                                    'House number',
                                    false,
                                    RegisterFieldControllers
                                        .houseNumberController),
                              ),
                            ]),
                        // State
                        SizedBox(height: 4.0),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                child: DefaultTextField(
                                    TextInputType.text,
                                    'State',
                                    false,
                                    RegisterFieldControllers.stateController),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                child: DefaultTextField(
                                    TextInputType.number,
                                    'Postalcode',
                                    false,
                                    RegisterFieldControllers
                                        .postalCodeController),
                              ),
                            ]),
                        SizedBox(height: 4.0),
                        DefaultTextField(TextInputType.text, 'Country', false,
                            RegisterFieldControllers.countryController),
                        SizedBox(height: 4.0),

                        // only visible of Customer
                        Visibility(
                            visible: (state is RegisterCustomerState),
                            child: Column(children: <Widget>[
                              DefaultTextField(
                                  TextInputType.text,
                                  'Solar Installation Provider (Company)',
                                  false,
                                  RegisterFieldControllers.companyController),
                            ])),

                        // only visible of Company Admin
                        Visibility(
                            // visible: (_role == Rolls.CompanyAdmin),
                            visible: (state is RegisterCompanyAdminState),
                            child: Column(children: <Widget>[
                              SizedBox(height: 4.0),
                              DefaultTextField(
                                  TextInputType.text,
                                  'Company Name',
                                  false,
                                  RegisterFieldControllers
                                      .companyNameController),
                              SizedBox(height: 4.0),
                              DefaultTextField(
                                  TextInputType.text,
                                  'Company Website',
                                  false,
                                  RegisterFieldControllers
                                      .companyWebsiteController),
                            ])),

                        SizedBox(height: 4.0),
                        DefaultTextField(TextInputType.emailAddress, 'Email',
                            false, RegisterFieldControllers.emailController),
                        SizedBox(height: 4.0),
                        DefaultTextField(
                            TextInputType.visiblePassword,
                            'Password',
                            true,
                            RegisterFieldControllers.passwordController),
                        SizedBox(height: 4.0),
                        DefaultTextField(
                            TextInputType.visiblePassword,
                            'Confirm password',
                            true,
                            RegisterFieldControllers.confirmPasswordController),
                        SizedBox(height: 16.0),
                        Container(
                            padding: EdgeInsets.only(bottom: 12),
                            child: registerButton)
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Card();
        }
      },
    );
  }

  void regButtonPress() {
    bool fieldsFilled = RegisterFieldControllers.checkFieldsFilled(_role);
    if (fieldsFilled) {
      User user;
      if (_role == Rolls.CompanyAdmin) {
        user = CompanyAdmin(
          firstname: RegisterFieldControllers.firstNameController.text,
          lastname: RegisterFieldControllers.lastNameController.text,
          id: "", //empty id
          email: RegisterFieldControllers.emailController.text,
          country: RegisterFieldControllers.countryController.text,
          state: RegisterFieldControllers.stateController.text,
          postalcode: RegisterFieldControllers.postalCodeController.text,
          street: RegisterFieldControllers.streetController.text,
          houseNumber: RegisterFieldControllers.houseNumberController.text,
          phoneNumber: RegisterFieldControllers.phoneNumberController.text,
          companyName: RegisterFieldControllers.companyNameController.text,
          companyWebsite:
              RegisterFieldControllers.companyWebsiteController.text,
          companyEmployeesIds: [], //empty array
        );
      } else {
        user = Customer(
          firstname: RegisterFieldControllers.firstNameController.text,
          lastname: RegisterFieldControllers.lastNameController.text,
          id: "", //empty id
          email: RegisterFieldControllers.emailController.text,
          country: RegisterFieldControllers.countryController.text,
          state: RegisterFieldControllers.stateController.text,
          postalcode: RegisterFieldControllers.postalCodeController.text,
          street: RegisterFieldControllers.streetController.text,
          houseNumber: RegisterFieldControllers.houseNumberController.text,
          phoneNumber: RegisterFieldControllers.phoneNumberController.text,
          solarServiceProviderId:
              RegisterFieldControllers.companyController.text,
        );
      }

      BlocProvider.of<UserLoginBloc>(context)
          .dispatch(UserRegisterEvent(user, "password"));
      RegisterFieldControllers.clearFields();
    }
  }

  void confirmRegisterPress() {
    BlocProvider.of<UserLoginBloc>(context).dispatch(LoginShowUiEvent());
  }

  void dispatchRolechangingEvent(role) {
    _role = role;
    if (role == Rolls.CompanyAdmin) {
      BlocProvider.of<UserLoginBloc>(context)
          .dispatch(ShowRegisterCompanyAdminUiEvent());
    } else {
      BlocProvider.of<UserLoginBloc>(context)
          .dispatch(ShowRegisterCustomerUiEvent());
    }
  }

  String getAddressText(state) {
    if (state is RegisterCustomerState) {
      return "Address of Installation";
    } else {
      return "Address of Company";
    }
  }
}
