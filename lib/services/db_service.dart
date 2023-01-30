import 'package:ds/utils/keys.dart';
import 'package:ds/utils/lan.dart';
import 'package:shared_preferences/shared_preferences.dart';

final db = DBService.instance;

class DBService {
  DBService._();

  static DBService instance = DBService._();

  Future<String?> set() async {
    try {
      final db = await SharedPreferences.getInstance();
      await db.setString(keys.lan, currLan!);
      return null;
    } catch (e) {
      return 'error';
    }
  }

  Future<String> take() async {
    try {
      final db = await SharedPreferences.getInstance();
      final res = (db.get(keys.lan) as String?) ?? 'uz';
      return res;
    } catch (e) {
      print('take: $e');
      return 'uz';
    }
  }
}
