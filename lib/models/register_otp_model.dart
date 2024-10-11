import 'dart:convert';

class RegisterOTPModel {
  final String email;
  final String submittedOTP;

  RegisterOTPModel({
    required this.email,
    required this.submittedOTP,
  });


  Map<String, dynamic> tomap() {
    return <String, String>{'email': email, 'otp': submittedOTP};
  }

  String toJson() {
    print(tomap());
    return jsonEncode(tomap());}
}
