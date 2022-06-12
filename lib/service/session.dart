import 'package:to_do_app/service/shared_session_control.dart';

class Session {
  static bool? _session;

  static bool get session {
    _sessionControl();
    return _session ?? false;
  }

  static set session(bool value) {
    _session = value;
  }

  static _sessionControl() async {
    SharedSessionControl().getSession().then((value) {
      Session.session = value;
    });
    print('SESSİON clasında session değeri : $session');
  }
}
