class User {
  static late String username = "Yogeshk4124",
      email = "yogeshk4124@gmail.com",
      fname = "Yogesh",
      lname = "Kumar";
  static late String logintoken;
  static UserCreate(String uname, String e, String ltoken) {
    username = uname;
    email = e;
    logintoken = ltoken;
  }

  static UserLogin(String e, String ltoken) {
    logintoken = ltoken;
    email = e;
  }

  static String getTtoken() {
    return logintoken;
  }
}
