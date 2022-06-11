class User {
  int? id;
  String? userName;
  String? password;

  User({this.userName, this.password});
  User.withId(this.id, this.userName, this.password);

  User.fromMap(Map<String, dynamic> userMap) {
    this.id = userMap['id'];
    this.userName = userMap['userName'];
    this.password = userMap['password'];
  }

  Map<String, dynamic> toMap(User user) {
    Map<String, dynamic> userMap = {
      'id': user.id,
      'userName': user.userName,
      'password': user.password,
    };
    return userMap;
  }
}
