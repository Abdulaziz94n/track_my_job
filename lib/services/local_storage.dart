import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../controllers/theme_controller.dart';

class LocalStorage {
  static final _storage = FlutterSecureStorage();

  static const _languageKey = 'lang';
  static const _themeKey = 'theme';

  static Future setLang(String langCode) async =>
      await _storage.write(key: _languageKey, value: langCode);

  static Future<String?>? getLang() async =>
      await _storage.read(key: _languageKey);

  static Future setTheme(ThemeModes theme) async {
    await _storage.write(key: _themeKey, value: theme.name);
  }

  static Future<String?> getTheme() async {
    return await _storage.read(key: _themeKey);
  }
}
