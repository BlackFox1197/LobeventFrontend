import 'package:auditergy_flutter/ui/utils/color_constants.dart';
import 'package:auditergy_flutter/ui/bloc/user/user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomToggleButton extends StatefulWidget {
  final Function() callParent;
  CustomToggleButton({this.callParent});

  @override
  _CustomToggleButton createState() => _CustomToggleButton();
}

class _CustomToggleButton extends State<CustomToggleButton> {
  Color loginTextColor = Colors.black;
  Color registerTextColor = Colors.white;
  bool isExistingUser = true;
  double _marginLeft = 4;
  double _marginRight = 4;

  @override
  void initState() {
    super.initState();
  }

  void toggleCard() {
    widget.callParent();
    if (!isExistingUser) {
      setState(() {
        isExistingUser = !isExistingUser;
        loginTextColor = Colors.black;
        registerTextColor = Colors.white;
        _marginRight = MediaQuery.of(context).size.width / 12;
        _marginLeft = 4;
        BlocProvider.of<UserLoginBloc>(context).dispatch(LoginShowUiEvent());
      });
    } else {
      setState(() {
        isExistingUser = !isExistingUser;
        loginTextColor = Colors.white;
        registerTextColor = Colors.black;
        _marginRight = 4;
        _marginLeft = MediaQuery.of(context).size.width / 12;
      });
      BlocProvider.of<UserLoginBloc>(context)
          .dispatch(ShowRegisterCompanyAdminUiEvent());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FlatButton(
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: Colors.transparent,
        onPressed: () {
          toggleCard();
        },
        child: Container(
          width: MediaQuery.of(context).size.width / 6,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(26.0),
            color: ColorConstants.lightgrey,
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              AnimatedContainer(
                duration: Duration(milliseconds: 350),
                margin: EdgeInsets.only(
                    right: _marginRight, top: 4, left: _marginLeft, bottom: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width / 12,
                height: 48,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(left: 14),
                    width: MediaQuery.of(context).size.width / 12,
                    child: Text("Login",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            color: loginTextColor,
                            fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 12,
                    child: Text("Register",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 21,
                            color: registerTextColor,
                            fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
