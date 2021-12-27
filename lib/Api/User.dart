class User {
  static late String username, email, logintoken;

  User(String uname, String e, String ltoken) {
    username = uname;
    email = e;
    logintoken = ltoken;
  }
  String getTtoken() {
    return logintoken;
  }
}
