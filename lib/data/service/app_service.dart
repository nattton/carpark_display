import 'dart:ui';

import 'package:hexcolor/hexcolor.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keyFontColor = "FONT_COLOR";
const keyBackgroundColor = "BACKGROUD_COLOR";

const defaultFontColor = "#ff0000";
const defaultBackgroundColor = "#000000";

const keyResidentEntry = "MemberEntry";
const keyResidentExit = "MemberExit";
const keyVisitorEntry = "VisitorEntry";
const keyVisitorExit = "VisitorExit";
const keyOverdueEntry = "OverdueEntry";
const keyOverdueExit = "OverdueExit";

const defaultMemberEntry = "Welcome ยินดีต้อนรับ";
const defaultMemberExit = "ขอให้เดินทางโดยสวัสดิภาพ";
const defaultVisitorEntry = "Visitor กรุณาลงทะเบียน";
const defaultVisitorExit = "Visitor กรุณาคืนบัตร";
const defaultOverdueEntry = "ค้างค่าส่วนกลาง กรุณาติดต่อนิติฯ";
const defaultOverdueExit = "ค้างค่าส่วนกลาง กรุณาติดต่อนิติฯ";

class AppService {
  final SharedPreferences _pref;

  AppService({required SharedPreferences pref}) : _pref = pref;

  String get fontText => _getText(keyFontColor);
  String get backgroundText => _getText(keyBackgroundColor);

  Color get fontColor => _getColor(keyFontColor);
  Color get backgroundColor => _getColor(keyBackgroundColor);

  String _getText(String key) {
    String? fontText = _pref.getString(key);
    if (fontText != null && fontText.isNotEmpty) {
      return fontText;
    }
    if (key == keyFontColor) {
      return defaultFontColor;
    }
    return defaultBackgroundColor;
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
    if (key == keyFontColor) {
      return HexColor(defaultFontColor);
    }
    return HexColor(defaultBackgroundColor);
  }

  Future<bool> saveFontColor(String value) async {
    return _pref.setString(keyFontColor, value);
  }

  Future<bool> saveBackgroundColor(String value) async {
    return _pref.setString(keyBackgroundColor, value);
  }

  String _getKeyEntry(String status) {
    return switch (status) {
      'resident' => keyResidentEntry,
      'visitor' => keyVisitorEntry,
      'overdue' => keyOverdueEntry,
      String() => keyVisitorEntry,
    };
  }

  String _getKeyExit(String status) {
    return switch (status) {
      'resident' => keyResidentExit,
      'visitor' => keyVisitorExit,
      'overdue' => keyOverdueExit,
      String() => keyVisitorExit,
    };
  }

  String _getDefaultEntry(String memberType) {
    return switch (memberType) {
      'resident' => defaultMemberEntry,
      'visitor' => defaultVisitorEntry,
      'overdue' => defaultOverdueEntry,
      String() => defaultVisitorEntry,
    };
  }

  String _getDefaultExit(String memberType) {
    return switch (memberType) {
      'resident' => defaultMemberExit,
      'visitor' => defaultVisitorExit,
      'overdue' => defaultOverdueExit,
      String() => defaultVisitorExit,
    };
  }

  Future<bool> saveEntryValue(
      {required String memberType, required String value}) async {
    return _pref.setString(_getKeyEntry(memberType), value);
  }

  String getEntryValue({required String memberType}) {
    return _pref.getString(_getKeyEntry(memberType)) ??
        _getDefaultEntry(memberType);
  }

  Future<bool> saveExitValue(
      {required String memberType, required String value}) async {
    return _pref.setString(_getKeyExit(memberType), value);
  }

  String getExitValue({required String memberType}) {
    return _pref.getString(_getKeyExit(memberType)) ??
        _getDefaultExit(memberType);
  }
}
