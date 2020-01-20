import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lobevent/Presentation/CustomWidgets/EventSwiper.dart';


class Feed extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildScrollable(context),
      ),
    );
  }

  Widget _buildScrollable(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverToBoxAdapter(
          child: EventSwiper()
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Container(
                alignment: Alignment.center,
                color: Colors.teal[100 * (index % 9)],
                child: Text('Grid Item $index'),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}
