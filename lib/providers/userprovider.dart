import 'package:coswan/models/user_model.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
      id: '',
      storename: '',
      address: '',
      role: '',
      email: '',
      gstnumber: '',
      city: '',
      password: '',
      phonenumber: 0,
      acceptedTerms: false,
      token: '',
      fcmRegisterToken: '');

  User get user => _user;

  //
  void setUSer(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  //
  void setUSerFromModel(User user) {
    _user = user;
    notifyListeners();
  }

  // late String _role;
  // late String _token;
  // late String _userId;
  // late String _gstnumber;
  // late String _storename;
  // late String _email;

  // String get token => _token;
  // //String get role => _role;
  // String get userId => _userId;
  // String get gst => _gstnumber;
  // String get storename => _storename;
  // String get email => _email;
  // void loginmethodProvider(String token, String role, String userId,
  //     String gstnumber, String storename, String email) {
  //   _token = token;
  //   // _role = role;
  //   _userId = userId;
  //   _gstnumber = gstnumber;
  //   _storename = storename;
  //   _email = email;
  //   notifyListeners();
  // }

  void clearUserData() {
    _user = User(
        id: '',
        storename: '',
        address: '',
        role: '',
        email: '',
        gstnumber: '',
        city: '',
        password: '',
        phonenumber: 0,
        acceptedTerms: false,
        token: '' ,
        fcmRegisterToken: '');
    notifyListeners();
  }
}
