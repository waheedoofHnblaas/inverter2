import 'package:get/get.dart';
import 'package:invertar_us/controllers/auth_controller/login_contoller.dart';
import 'package:invertar_us/core/services/services.dart';

MyServices myServices = Get.find();
String serverLinkHost = myServices.sharedPreferences.getString('link') ??
    LoginControllerImp().link.text;

//========================    Auth    ===========================
String ssignUpLink = '/rest-auth/login/';
String sloginLink = '/rest-auth/login/';
String sregisteration = '/rest-auth/registration/';
String schange_password = '/rest-auth/password/change/';
String schange_password_normal = '/rest-auth/normal/password/change/';
String sdelete_user = '/rest-auth/user/delete/';

// =============================User Setting=================================
String suser_setting = '/api/user/settings/get/';
String suser_settings_edite = '/api/user/settings/edit/';
String calibrate_ldr_sensor = '/api/calibrate_ldr_sensor/';

//========================    home    ===========================
String sgetUserDetails = '/rest-auth/user/';
String sgetDataInfo = '/api/data/get/';
String sresetData = '/reset/';
String sresetSettingsData = '/api/reset/inverter_parameters/';

//========================    inverter    ===========================
String sgetInverterSettingsInfo = '/api/inverter/settings/get/';
String sgetInverterCommands = '/api/command/get/';
String seditInverterSetting = '/api/inverter/settings/edit/';
