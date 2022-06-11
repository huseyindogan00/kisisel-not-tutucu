import 'package:to_do_app/data/db_helper.dart';
import 'package:to_do_app/model/user.dart';

class EntryViewModel {
  Future<bool> isCurrentUser() async {
    var result = await DbHelper().getUsers();
    return result.isNotEmpty ? true : false;
  }

  Future<bool> addUser(User user) async {
    var result = await DbHelper().addUser(user);
    return result is bool;
  }

  Future<bool> login(String userName, String password) async {
    bool result = await DbHelper().login(userName, password).then((value) {
      return value;
    });
    return result;
  }

  Future<int> deleteUser(int id, String tableName) async {
    var result = await DbHelper().delete(id, tableName);
    return result;
  }
}
