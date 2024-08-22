class Config {
  static const String appName = "resumecraft";
  // static const String apiUrl = "http://localhost:3000/api/"; // for web
  // static const String apiUrl = "10.0.0.7:4000/api/"; // for android emulator (nor working for some reason)
  static const String apiUrl =
      "http://192.168.1.65:3000/api/"; // for physical device || andriod emulator

  // ===================== public Routes ===========================
  static const String register = "user/register";

  // ===================== Auth Routes ===========================
  static const String login = "auth/login";
  static const String userProfile = "user/profile";
  static const String getPersonalDetails =
      "userdetail/userdetails-by-currentuser";
  static const String createPersonalDetail = 'userdetail/create-userdetail';
  static const String personalDetailRUDbyID =
      'userdetail/'; // RUD--> read, update, delete
}
