import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class User {
  final String id;
  final String storename;
  final String address;
  final String role;
  final String email;
  final String gstnumber;
  final String city;
  final String password;
  final int phonenumber;
  final String token;
  final String fcmRegisterToken;

  // verificationToken: String,
  //otp: String,

  final bool acceptedTerms;
  User(
      {required this.id,
      required this.storename,
      required this.address,
      required this.role,
      required this.email,
      required this.gstnumber,
      required this.city,
      required this.password,
      required this.phonenumber,
      required this.acceptedTerms,
      required this.token,
      required this.fcmRegisterToken});
  //otpVerified;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'storename': storename,
      'address': address,
      'role': role,
      'email': email,
      'gstnumber': gstnumber,
      'city': city,
      'password': password,
      'phonenumber': phonenumber,
      'acceptedTerms': acceptedTerms,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
        id: map['_id'] ?? map['UserId'] ?? '',
        storename: map['storename'] ?? '',
        address: map['address'] ?? '',
        role: map['role'] ?? '',
        email: map['email'] ?? '',
        gstnumber: map['gstnumber'] ?? '',
        city: map['city'] ?? '',
        password: map['password'] ?? '',
        phonenumber: map['phonenumber'] ?? 0,
        acceptedTerms: map['acceptedTerms'] ?? false,
        token: map['token'] ?? '',
        fcmRegisterToken: ''
        );
      
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
