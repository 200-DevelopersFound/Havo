class User {
  static late String username, email, fname, lname;
  static late String logintoken;
  static UserCreate(String uname, String e, String ltoken, String f, String l) {
    username = uname;
    email = e;
    logintoken = ltoken;
    fname = f;
    lname = l;
  }

  static UserLogin(String e, String ltoken) {
    logintoken = ltoken;
    email = e;
  }

  static String getTtoken() {
    return logintoken;
  }
}
