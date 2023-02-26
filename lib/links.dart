class AppLinks {
  static const String serverLink = 'http://192.168.1.101:8000';

  //192.168.43.206


  //========================    Auth    ===========================
  static const String signUpLink = '$serverLink/rest-auth/login/';
  static const String loginLink = '$serverLink/rest-auth/login/';
  static const String registeration = '$serverLink/rest-auth/registration/';
  static const String change_password =
      '$serverLink/rest-auth/password/change/';
  static const String change_password_normal =
      '$serverLink/rest-auth/normal/password/change/';
  static const String delete_user = '$serverLink/rest-auth/user/delete/';

  // =============================User Setting=================================
  static const String user_setting = '$serverLink/api/user/settings/get/';

  //========================    home    ===========================
  static const String getUserDetails = '$serverLink/rest-auth/user/';
  static const String getDataInfo = '$serverLink/api/data/get/';

//========================    inverter    ===========================
  static const String getInverterSettingsInfo = '$serverLink/api/inverter/settings/get/';
  static const String getInverterCommands = '$serverLink/api/command/get/';
  static const String editInverterSetting = '$serverLink/api/inverter/settings/edit/';

}
