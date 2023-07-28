import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  setApplicationStatus(status) async {
    final pref = await SharedPreferences.getInstance();
    pref.setBool("status", status);
  }

  getApplicationStatus() async {
    final pref = await SharedPreferences.getInstance();
    final status = pref.getBool("status");
    return status;
  }
}
