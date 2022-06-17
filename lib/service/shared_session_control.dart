import 'package:shared_preferences/shared_preferences.dart';

class SharedSessionControl {
  Future<SharedPreferences> sharedPreference = SharedPreferences.getInstance();

  SharedPreferences? shared;

  Future<bool> getSession() async {
    shared = await sharedPreference;

    if (shared!.containsKey('session')) {
      bool result = shared!.getBool('session')!;
      print('SESSİON keyi var : $result');
      return result;
    } else {
      print('SESSİON DEĞERİ YOK');
      await sessionSave(false);
      return false;
    }
  }

  sessionSave(bool state) async {
    shared = await sharedPreference;
    var result = await shared!.setBool('session', state);
    print('shared kaydetmeden döenen result : $result');
  }

  static sessionDelete() {}
}
