import 'package:auditergy_flutter/ui/bloc/user/user_bloc.dart';
import 'package:auditergy_flutter/ui/pages/dashboard/dashboard_screen.dart';
import 'package:auditergy_flutter/ui/pages/login/utils/registerfield_controllers.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:auditergy_flutter/ui/widgets/default_textfield.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginForm extends StatefulWidget {
  final BuildContext context;
  final void Function() callParent;
  const LoginForm({this.context, this.callParent});

  @override
  _LoginForm createState() => _LoginForm(context);
}

class _LoginForm extends State<LoginForm> {
  _LoginForm(BuildContext context);
  UserLoginBloc _UserLoginBloc;

  bool isChecked = false;

  static final loginNameController = TextEditingController();
  static final loginPasswordController = TextEditingController();
  var loginFieldsControllerList = [
    loginNameController,
    loginPasswordController
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginButton = Container(
      width: MediaQuery.of(context).size.width / 4,
      height: 48,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 2.0,
        onPressed: () {
          loginButtonPress();
        },
        padding: EdgeInsets.all(12),
        color: ColorConstants.auditergyHighlight,
        child: Text('LogIn',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    final loginSuccessButton = Container(
      width: 144,
      height: 48,
      margin: EdgeInsets.all(12),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 2.0,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DashboardScreen()),
          );
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

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        widget.callParent();
      },
    );

    return BlocBuilder<UserLoginBloc, UserLoginState>(
      bloc: _UserLoginBloc,
      builder: (context, state) {
        if (state is UserLoggedInState) {
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
                      "Login Successful",
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  loginSuccessButton,
                ],
              ));
        }
        if (state is UserLoginLoadingState) {
          return Card(
              elevation: 5.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                child: Text("loading..."),
              ));
        } else if (state is InitialUserLoginState) {
          return Card(
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            child: Container(
              padding:
                  EdgeInsets.only(top: 42, right: 24, bottom: 12, left: 24),
              width: MediaQuery.of(context).size.width / 2,
              // height: MediaQuery.of(context).size.height / 2.5
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  DefaultTextField(TextInputType.emailAddress, 'Email', false,
                      loginNameController),
                  SizedBox(height: 8.0),
                  DefaultTextField(TextInputType.visiblePassword, 'Password',
                      true, loginPasswordController),
                  SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Checkbox(
                              value: isChecked,
                              onChanged: (value) {
                                setState(() {
                                  isChecked = value;
                                });
                              }),
                          Text("Remember Me")
                        ],
                      ),
                      forgotLabel
                    ],
                  ),
                  loginButton,
                ],
              ),
            ),
          );
        } else {
          return Card();
        }
      },
    );
  }

  void loginButtonPress() {
    BlocProvider.of<UserLoginBloc>(context).dispatch(
        UserLoginEvent(loginNameController.text, loginPasswordController.text));
    loginNameController.clear();
    loginPasswordController.clear();
    RegisterFieldControllers.clearFields();
  }
}
