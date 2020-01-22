
class RegistrationResponse {
  bool success;

  RegistrationResponse({this.success});

  factory RegistrationResponse.fromJSON(Map<String, dynamic> json) {
    final registrationResponse = RegistrationResponse(
      success: json['bool'] as bool,
    );
    return registrationResponse;
  }
}
