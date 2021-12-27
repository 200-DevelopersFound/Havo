class User {
  static late String username, email, logintoken;

  static UserCreate(String uname, String e, String ltoken) {
    username = uname;
    email = e;
    logintoken = ltoken;
  }

  static UserLogin(String e, String ltoken) {
    email = e;
    logintoken = ltoken;
  }

  static String getTtoken() {
    return logintoken;
  }
}
