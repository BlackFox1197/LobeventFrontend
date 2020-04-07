// A user of the application
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class User extends Equatable {
  final String firstname;
  final String lastname;
  final String id;
  final String email;

  //adress components
  final String country;
  final String state;
  final String postalcode;
  final String street;
  final String houseNumber;
  final String phoneNumber;

  User({
    @required this.firstname,
    @required this.lastname,
    @required this.id,
    @required this.email,
    @required this.country,
    @required this.state,
    @required this.postalcode,
    @required this.street,
    @required this.houseNumber,
    @required this.phoneNumber,
  }) : super([
          firstname,
          lastname,
          id,
          email,
          country,
          state,
          postalcode,
          street,
          houseNumber,
          phoneNumber,
        ]);

  // if there is logic in entities -> write test for logic in entities!

/*   @override
  operator ==(dynamic user) => user is User && uid == user.uid; */

}
