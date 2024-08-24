class Config {
  static const String appName = "resumecraft";
  // static const String apiUrl = "http://localhost:3000/api/"; // for web
  // static const String apiUrl =
  //     "10.0.0.7:4000/api/"; // for android emulator (not working for some reason)
  static const String apiUrl =
      "http://192.168.1.65:3000/api/"; // for physical device || andriod emulator

  // 192.168.18.9
  // 192.168.1.65

  // ===================== public Routes ===========================
  static const String register = "user/register";

  // ===================== Auth Routes ===========================a
  static const String login = "auth/login";
  static const String userProfile = "user/profile";
  static const String getPersonalDetails =
      "userdetail/userdetails-by-currentuser";
  static const String createPersonalDetail = 'userdetail/create-userdetail';
  static const String personalDetailByID =
      'userdetail/'; // RUD--> read, update, delete
  static const String createEducation = 'education/create-edu';
  static const String educationByPersonalDetail =
      "education/edu-by-userdetail/";
}
