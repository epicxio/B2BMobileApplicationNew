import 'package:get_storage/get_storage.dart';

class StorageService {
  final storage = GetStorage();
  Future<void> saveUserLoginDataForReme(
    String email,
    String token,
  ) async {
    await storage.write('email', email);
    await storage.write('password', token);
  }

  void removeRemUserData() {
    storage.remove('email');
    storage.remove('password');
  }

  String? getEmail() {
    return storage.read('email');
  } 

  String? getPWD() {
    return storage.read('password');
  }
}
