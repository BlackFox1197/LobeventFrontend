import 'dart:developer';

import 'package:auditergy_flutter/ui/bloc/user/user_bloc.dart';
import 'package:auditergy_flutter/ui/pages/login/widgets/forgot_password_form.dart';
import 'package:auditergy_flutter/ui/pages/login/widgets/loginform.dart';
import 'package:auditergy_flutter/ui/pages/login/widgets/registerform.dart';
import 'package:auditergy_flutter/ui/widgets/customToggleButton.dart';
import 'package:flutter/material.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../injection_container.dart';

class Login extends StatefulWidget {
  final String title;
  Login({Key key, this.title}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isExistingUser = true;
  bool isForgotPassword = false;

  UserLoginBloc _UserLoginBloc;
  ForgotPasswordBloc _ForgotPasswordBloc;

  @override
  void initState() {
    _UserLoginBloc = sl<UserLoginBloc>();
    _ForgotPasswordBloc = sl<ForgotPasswordBloc>();
    super.initState();
  }

  toggleExistingUser() {
    setState(() {
      isExistingUser = !isExistingUser;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserLoginBloc>(
      builder: (context) => _UserLoginBloc,
      child: Scaffold(
        // background
        backgroundColor: Colors.white,
        body: Stack(children: <Widget>[
          Column(children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: new BoxDecoration(
                  gradient: new LinearGradient(colors: [
                ColorConstants.auditergyBlue,
                ColorConstants.auditergyPurple
              ], begin: new Alignment(-0.25, -1), end: new Alignment(0, 1))),
            ),
          ]),
          //toggle button login - register
          Container(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height / 1.45),
            child: Center(
              child: FlatButton(
                hoverColor: Colors.transparent,
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onPressed: () {
                  dispatchToggleLoginRegister(context, isExistingUser);
                },
                child: CustomToggleButton(callParent: toggleExistingUser),
              ),
            ),
          ),
          // Login/Register Card
          BlocBuilder<UserLoginBloc, UserLoginState>(builder: (context, state) {
            if (state is AbstractLoginState) {
              return Center(
                child: LoginForm(context: context, callParent: showForgotCard),
              );
            } else if (state is AbstractRegisterState) {
              return Center(child: RegisterForm(context));
            } else if (state is LoginErrorState) {
              return Center(
                  child: Card(
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
                              "Some error occured: " + state.message,
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Container(
                            width: 144,
                            height: 48,
                            margin: EdgeInsets.all(12),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              elevation: 2.0,
                              onPressed: () {
                                showRegiserCard();
                              },
                              padding: EdgeInsets.all(12),
                              color: ColorConstants.auditergyHighlight,
                              child: Text('OK',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      )));
            } else {
              return Container();
            }
          }),
          // Forgot Password UI
          BlocProvider<ForgotPasswordBloc>(
            builder: (context) => _ForgotPasswordBloc,
            child: BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
                builder: (context, state) {
              if (state is ForgotPasswordEmptyState) {
                return Container();
              } else if (state is InitialForgotPasswordState) {
                return Center(child: ForgotPasswordForm(context));
              } else if (state is ForgotPasswordRecoverdState) {
                return Center(
                    child: Text(
                        "Password Recoverd, an email has been sent to the entered address."));
              } else if (state is ErrorForgotPasswordState) {
                return Container(child: Text("Error: " + state.message));
              } else {
                return Container();
              }
            }),
          ),
        ]),
      ),
    );
  }

  void dispatchToggleLoginRegister(context, isExistingUser) {
    isExistingUser = !isExistingUser;
  }

  void showForgotCard() {
    _ForgotPasswordBloc.dispatch(ForgotPasswordShowUiEvent());
  }

  void showRegiserCard() {
    _UserLoginBloc.dispatch(LoginShowUiEvent());
  }
}
