import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  FlutterSecureStorage secureStorage = FlutterSecureStorage();
  //store
  Future<void> saveData(String key, String value) async {
    await secureStorage.write(key: key, value: value);
  }

  //read
  Future<String> getData(String key) async {
    return await secureStorage.read(key: key) ?? "";
  }

  Future<void> deleteData(String key) async {
    await secureStorage.delete(key: key);
  }

  Future<void> deleteAll() async {
    await secureStorage.deleteAll();
  }
}
