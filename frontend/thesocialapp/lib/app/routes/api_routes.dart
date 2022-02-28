class APIRoutes {
  //! Basic info
  static const baseURL = "http://192.168.100.183:8080";
  static final headers = {
    'content-type': 'application/json;unicode=UTF-8',
    'Accept': 'application/json',
    "Access-Control-Allow-Origin": "*",
  };

  //! Authentication
  static const String loginURL = baseURL + "/user/login";
  static const String signupUrl = baseURL + "/user/signup";
  static const String decodeJwtUrl = baseURL + "/user/decode-jwt";

  //! Posts
  static const String addPostUrl = baseURL + "/post/add/";
  static const String fetchPostsUrl = baseURL + "/post/";
}
