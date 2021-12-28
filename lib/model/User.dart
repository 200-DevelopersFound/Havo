class User {
  static late String username, email;
  static String logintoken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxYzk3YWI2YmRiY2MyOGI5NGI3Yjc2NSIsInRva2VuX2lkIjoiMzEzMVVIUlExMzMyTlNQTSIsImlhdCI6MTY0MDYyNjM4N30.6byNE5eCihIMYIzavswnF10O-d_cor9MXWZ7u9JgR8c";

  static UserCreate(String uname, String e, String ltoken) {
    username = uname;
    email = e;
    // logintoken =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxYzk3YWI2YmRiY2MyOGI5NGI3Yjc2NSIsInRva2VuX2lkIjoiMzEzMVVIUlExMzMyTlNQTSIsImlhdCI6MTY0MDYyNjM4N30.6byNE5eCihIMYIzavswnF10O-d_cor9MXWZ7u9JgR8c";
  }

  static UserLogin(String e, String ltoken) {
    email = e;
    // logintoken =
    //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjYxYzk3YWI2YmRiY2MyOGI5NGI3Yjc2NSIsInRva2VuX2lkIjoiMzEzMVVIUlExMzMyTlNQTSIsImlhdCI6MTY0MDYyNjM4N30.6byNE5eCihIMYIzavswnF10O-d_cor9MXWZ7u9JgR8c";
  }

  static String getTtoken() {
    return logintoken;
  }
}
