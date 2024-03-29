import 'dart:async';

import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_data_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/controllers/home_controllers/user_setting_controller.dart';
import 'package:invertar_us/data/datasource/remote/data-remote/resetData.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth-remote/userDetails.dart';
import '../../route.dart';

class SystemUserControllerImp extends GetxController {
  StatusRequest statusRequest = StatusRequest.success;
  StatusRequest statusRequest2 = StatusRequest.success;
  final UserDetails userDetails = UserDetails(Get.find());
  MyServices myServices = Get.find();
  String username = '';
  bool isAdmin = false;

  @override
  void onInit() async {
    username = myServices.sharedPreferences.get('username').toString();
    await getUserData();
    super.onInit();
  }

  Future getUserData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await userDetails.userDetails(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    print('======================');
    print(response);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success'] != null) {
        isAdmin = response['user detail']['admin'];
      } else {
        Get.showSnackbar(
          GetSnackBar(
            title: response['detail'],
          ),
        );
      }
    } else {
      Get.snackbar('Warring', 'Connection Error');
      statusRequest = StatusRequest.failure;
    }
    // dataModel = DataModel.fromJson(AppStaticData.data);
    update();
  }

  String getBool(int value) {
    if (value == 1) {
      return 'ON';
    } else {
      return 'OFF';
    }
  }

  Future<void> logout() async {
    UserSettingController userSettingController = Get.find();
    InverterDataController inverterDataController = Get.find();
    inverterDataController.timer.cancel();
    inverterDataController.timer2.cancel();
    await userSettingController.saveHomeValue();
    await Get.offAllNamed(AppPages.login);
  }

  void toRegisterPage() {
    Get.toNamed(AppPages.register);
  }

  void toChangePasswordPage() {
    Get.toNamed(AppPages.changePassword);
  }

  void toChangePasswordNormalPage() {
    Get.toNamed(AppPages.changePasswordNormal);
  }

  Future<void> toInverterSettingsPage() async {
    Timer(const Duration(seconds: 2), () async {
      InverterSettingsController inverterSettingsController = Get.find();

      await inverterSettingsController.resetEditSettingsMap();
      inverterSettingsController.update();
    });
    UserSettingController userSettingController = Get.find();
    userSettingController.update();
    await Get.toNamed(AppPages.inverterSettingPage);
  }

  final ResetData resetData = ResetData(Get.find());

  reset(String inverterSerialNumber) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await resetData.resetData(
      inverterNumber: inverterSerialNumber,
    );
    statusRequest = handlingData(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Message'].toString() != '') {
        logout();
        Get.defaultDialog(
          title: 'Warning',
          middleText: response['Message'].toString(),
          backgroundColor: Get.theme.backgroundColor,
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Warning',
        middleText: 'something is wrong',
        backgroundColor: Get.theme.backgroundColor,
      );
      statusRequest = StatusRequest.failure;
    }
    update();
    print('validate');
  }

  resetSettings(String inverterSerialNumber) async {
    statusRequest2 = StatusRequest.loading;
    update();
    var response = await resetData.resetSettingsData(
      inverterNumber: inverterSerialNumber,
    );
    statusRequest2 = handlingData(response);
    print(response);
    if (statusRequest2 == StatusRequest.success) {
      if (response['Message'].toString() != '') {
        // logout();
        Get.defaultDialog(
          title: 'Warning',
          middleText: response['Message'].toString(),
          backgroundColor: Get.theme.backgroundColor,
        );

        statusRequest2 = StatusRequest.success;
      }
    } else {
      Get.defaultDialog(
        title: 'Warning',
        middleText: 'something is wrong',
        backgroundColor: Get.theme.backgroundColor,
      );
    }
    statusRequest2 = StatusRequest.success;
    update();
    print('validate');
  }
}
