import 'package:flutter/material.dart';
import 'package:lobevent/Presentation/Content/EventSwiper.dart';
import 'Presentation/Content/animation_exp/SwipeAnimation/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Lobevent', home: EventSwiper());
  }
}
