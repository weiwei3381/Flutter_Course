import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

const String kQrSpKey = 'qr-config';  // 保存的键

class SpStorage {
  SpStorage._(); // 私有化构造

  static SpStorage? _storage;
  SharedPreferences? _sp;

// 提供实例对象的访问途径
  static SpStorage get instance {
    _storage = _storage ?? SpStorage._();
    return _storage!;
  }

  Future<void> initSpWhenNull() async {
    if (_sp != null) return;
    _sp = _sp ?? await SharedPreferences.getInstance();
  }

  Future<bool> saveQr({required int pageCount, required String info}) async {
    await initSpWhenNull();
    String content = json.encode({"pageCount": pageCount, "info": info});
    return _sp!.setString(kQrSpKey, content);
  }

  Future<Map<String,dynamic>> readQrConfig() async {
    await initSpWhenNull();
    String content = _sp!.getString(kQrSpKey)??"{}";
    return json.decode(content);
  }
}
