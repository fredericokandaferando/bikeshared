import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static String userpontos = "";
  static String username = "";
  static String useremail = "";
  static int? idestacao;
  static const String ip = "http://192.168.98.182:8080";
  static Future<String?> getSessionId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('sessionId');
  }
}
