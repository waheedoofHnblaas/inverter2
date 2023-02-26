import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverterCommands_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/controllers/home_controllers/system_user_controller.dart';
import 'package:invertar_us/controllers/home_controllers/user_setting_controller.dart';

import 'controllers/auth_controller/login_contoller.dart';
import 'core/class/crud.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(GetMaterialController());
    Get.put(LoginControllerImp());
    Get.put(SystemUserControllerImp());
    Get.put(UserSettingController());
    Get.put(InverterSettingsController());
    Get.put(InverterCommandsController());

  }
}
