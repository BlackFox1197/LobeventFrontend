import 'package:flutter/material.dart';

class RouteBackAppBar extends AppBar{
  final BuildContext context;
  //String title;
  RouteBackAppBar({title,this.context}) : super(
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.pop(context),

      ),
  );

}