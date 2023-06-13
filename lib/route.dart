import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:invertar_us/views/screens/auth_screens/changePassword.dart';
import 'package:invertar_us/views/screens/auth_screens/change_password_normal.dart';
import 'package:invertar_us/views/screens/auth_screens/login.dart';
import 'package:invertar_us/views/screens/auth_screens/registerNewUser.dart';
import 'package:invertar_us/views/screens/home_screens/home_system_data.dart';
import 'package:invertar_us/views/screens/home_screens/inverter_settings_data.dart';
import 'package:invertar_us/views/screens/home_screens/user_setting_data.dart';

class AppPages {
  static const register = '/register';
  static const login = '/';
  static const changePassword = '/changePassword';
  static const changePasswordNormal = '/changePasswordNormal';

  static const systemData = '/systemData';
  static const inverterSettingPage = '/inverterSettingPage';
  static const userSettingPage = '/userSettingPage';

  static List<GetPage<dynamic>>? routes = [
    GetPage(
      name: AppPages.login,
      page: () => LoginPage(),
    ),
    GetPage(
      name: AppPages.register,
      page: () => const RegisterNewUserPage(),
    ),
    GetPage(
      name: AppPages.changePassword,
      page: () => const ChangePasswordPage(),
    ),
    GetPage(
      name: AppPages.changePasswordNormal,
      page: () => const ChangePasswordNormalPage(),
    ),
    GetPage(
      name: AppPages.systemData,
      page: () => HomeSystemDataPage(),
    ),
    GetPage(
      name: AppPages.inverterSettingPage,
      page: () => InverterSettingPage(),
    ),
    GetPage(
      name: AppPages.userSettingPage,
      page: () => const UserSettingPage(),
    ),
  ];
}
