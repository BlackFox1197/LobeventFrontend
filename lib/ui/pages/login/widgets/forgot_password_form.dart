import 'package:auditergy_flutter/ui/bloc/user/user_bloc.dart';
import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:auditergy_flutter/ui/widgets/default_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordForm extends StatefulWidget {
  final BuildContext context;
  ForgotPasswordForm(this.context);
  @override
  _ForgotPasswordForm createState() => _ForgotPasswordForm(context);
}

class _ForgotPasswordForm extends State<ForgotPasswordForm> {
  _ForgotPasswordForm(BuildContext context);
  ForgotPasswordBloc _ForgotPasswordBloc;

  static final forgotEmailController = TextEditingController();
  final String description =
      'In case you forgot your password please enter your email address. We will generate a new password and send it to the entered email:';

  @override
  Widget build(BuildContext context) {
    final acceptButton = Container(
      height: 48,
      width: MediaQuery.of(context).size.width / 6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 2.0,
        onPressed: () {
          acceptPress(forgotEmailController.text);
          forgotEmailController.clear();
        },
        padding: EdgeInsets.all(12),
        color: ColorConstants.auditergyHighlight,
        child: Text('Accept',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    final cancelButton = Container(
      height: 48,
      width: MediaQuery.of(context).size.width / 6,
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        elevation: 2.0,
        onPressed: () {
          cancelPress();
        },
        padding: EdgeInsets.all(12),
        color: ColorConstants.auditergyOrange,
        child: Text('Cancel',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold)),
      ),
    );

    return BlocBuilder<ForgotPasswordBloc, ForgotPasswordState>(
      bloc: _ForgotPasswordBloc,
      builder: (context, state) {
        if (state is InitialForgotPasswordState) {
          return Scaffold(
            backgroundColor: ColorConstants.darkgreyTransparent,
            body: Center(
              child: Card(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Container(
                  padding: EdgeInsets.all(24),
                  width: MediaQuery.of(context).size.width / 2,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Container(
                          child: new Text(
                        description,
                        style: TextStyle(fontSize: 20),
                      )),
                      // Buttons
                      Container(
                        child: DefaultTextField(TextInputType.emailAddress,
                            'Email address', false, forgotEmailController),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          cancelButton,
                          // SizedBox(width: 48),
                          acceptButton
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        } else {
          return Scaffold();
        }
      },
    );
  }

  void acceptPress(email) {
    print(email);
    BlocProvider.of<ForgotPasswordBloc>(context)
        .dispatch(ForgotPasswordRecoverEvent(email));
  }

  void cancelPress() {
    BlocProvider.of<ForgotPasswordBloc>(context)
        .dispatch(ForgotPasswordCloseUiEvent());
  }
}
