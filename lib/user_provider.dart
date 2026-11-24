
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String _nama = '';
  bool _isLoading = true;

  String get nama => _nama;
  bool get isLoading => _isLoading;

  static const String _namaKey = 'nama_pengguna';

  UserProvider() {
    loadName();
  }

  Future<void> loadName() async {
    final prefs = await SharedPreferences.getInstance();

    _nama = prefs.getString(_namaKey) ?? '';
    _isLoading = false;

    notifyListeners();
  }

  Future<void> saveName(String nama) async {
    if (nama.trim().isEmpty) return;

    final prefs = await SharedPreferences.getInstance();

    _nama = nama.trim();

    await prefs.setString(_namaKey, _nama);

    notifyListeners();
  }
}
