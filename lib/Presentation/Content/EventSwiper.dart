import 'package:flutter/material.dart';


class EventSwiper extends StatelessWidget {
  List cards =new List.generate(20, (i) => new CustomCard());

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        body: Container(
          child: Stack(
            children: cards,
          )

        )

    );

  }
}

class CustomCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Card(
        child: Positioned(
            top: 150,
            child: Card(
              color: Colors.blueAccent,
              child: Container(
                width: 300,
                height: 400,
                child: MaterialButton(
                  child: Text( 'Next Event' ),
                  onPressed: () {

                  },
                ),
              ),
            ),
          )
   );

  }
}
