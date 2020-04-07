import 'package:flutter/material.dart';

class RegisterRadioButtons extends StatefulWidget {
  final RadioCallback callParent;
  RegisterRadioButtons({this.callParent});

  @override
  _RegisterRadioButtons createState() => _RegisterRadioButtons();
}

enum Rolls { CompanyAdmin, Customer }

class _RegisterRadioButtons extends State<RegisterRadioButtons> {

  Rolls _role = Rolls.CompanyAdmin;

  void toggleRadio(Rolls value) {
    widget.callParent(value);
    setState(() {
     _role = value; 
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Row(children: <Widget>[
          Radio(
            value: Rolls.CompanyAdmin,
            groupValue: _role,
            onChanged: (Rolls value) {
              toggleRadio(value);
            },
          ),
          FlatButton(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              toggleRadio(Rolls.CompanyAdmin);
            },
            child: new Text(
              'Company Admin',
              style: new TextStyle(fontSize: 16),
            ),
          ),
        ]),
        Row(children: <Widget>[
          Radio(
            value: Rolls.Customer,
            groupValue: _role,
            onChanged: (Rolls value) {
              toggleRadio(value);
            },
          ),
          FlatButton(
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Colors.transparent,
            onPressed: () {
              toggleRadio(Rolls.Customer);
            },
            child: new Text(
              'Customer',
              style: new TextStyle(fontSize: 16),
            ),
          ),
        ]),
      ],
    );
  }
}

typedef RadioCallback = void Function(Rolls value);