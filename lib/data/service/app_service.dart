import 'dart:ui';

import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

const kFontColor = "FONT_COLOR";
const kBackgroundColor = "BACKGROUD_COLOR";
const kDefaultFontColor = "#ff0000";
const kDefaultBackgroundColor = "#000000";

class AppService {
  final SharedPreferences _pref;

  AppService({required SharedPreferences pref}) : _pref = pref;

  String get fontText => _getText(kFontColor);
  String get backgroundText => _getText(kBackgroundColor);

  Color get fontColor => _getColor(kFontColor);
  Color get backgroundColor => _getColor(kBackgroundColor);

  String _getText(String key) {
    String? fontText = _pref.getString(key);
    if (fontText != null && fontText.isNotEmpty) {
      return fontText;
    }
    if (key == kFontColor) {
      return kDefaultFontColor;
    }
    return kDefaultBackgroundColor;
  }

  Color _getColor(String key) {
    String? fontText = _pref.getString(key);
    if (fontText != null && fontText.isNotEmpty) {
      try {
        return HexColor(fontText);
      } catch (_) {
        return HexColor('#ffffff');
      }
    }
    if (key == kFontColor) {
      return HexColor(kDefaultFontColor);
    }
    return HexColor(kDefaultBackgroundColor);
  }

  Future<bool> saveFontColor(String value) async {
    return _pref.setString(kFontColor, value);
  }

  Future<bool> saveBackgroundColor(String value) async {
    return _pref.setString(kBackgroundColor, value);
  }
}
