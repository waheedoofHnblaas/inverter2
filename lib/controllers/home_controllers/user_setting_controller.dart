import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_data_controller.dart';
import 'package:invertar_us/data/datasource/remote/data-remote/editUserSettings.dart';
import 'package:invertar_us/route.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/data-remote/getCalibLDR.dart';
import '../../data/datasource/remote/data-remote/getUserSetting.dart';
import '../../data/model/userSettingModel.dart';

class UserSettingController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  final UserSettingData userSettingData = UserSettingData(Get.find());
  final EditUserSettingsData userSettingEdit = EditUserSettingsData(Get.find());
  final CalibLDRData calibLDRData = CalibLDRData(Get.find());
  MyServices myServices = Get.find();
  UserSetting userSettingModel = UserSetting();
  UserSetting userSettingModel2 = UserSetting();

  late TextEditingController readTimeText;

  late TextEditingController avgText;
  late TextEditingController solarPanels;
  late TextEditingController singleSolarMaxPower;

  late TextEditingController homeNameText;

  @override
  void dispose() {
    InverterDataController inverterDataController = Get.find();
    inverterDataController.timer.cancel();
    super.dispose();
  }

  @override
  Future<void> onInit() async {
    await initMethod();

    super.onInit();
  }

  initMethod() async {
    await getUserSettingData();
    readTimeText = TextEditingController(
      text: userSettingModel.readTime.toString(),
    );
    avgText = TextEditingController(
      text: userSettingModel.lastReadingsAvg.toString(),
    );
    solarPanels = TextEditingController(
      text: userSettingModel.solarPanels.toString(),
    );
    singleSolarMaxPower = TextEditingController(
      text: userSettingModel.singleSolarMaxPower.toString(),
    );

    homeNameText = TextEditingController(
      text: userSettingModel.homeName.toString(),
    );
    await saveHomeValue();
    update();
  }

  saveHomeValue() async {
    if (!myServices.sharedPreferences
        .containsKey('${homeNameText.text}homey')) {
      await myServices.sharedPreferences
          .setStringList('${homeNameText.text}homey', [
        myServices.sharedPreferences.getString('link').toString(),
        myServices.sharedPreferences.getString('username').toString(),
        myServices.sharedPreferences.getString('password').toString(),
        homeNameText.text,
      ]);
    }
  }

  Future clibLdr() async {
    statusRequest = StatusRequest.loading;
    update();

    var response = await calibLDRData.getCalibLDRData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        Get.snackbar('Warning', 'Confirm Sensor Successfully');
        // await getUserSettingData();
      } else {
        Get.snackbar('Warning', response['Message'].toString());
      }
    } else {
      Get.snackbar('Warning', 'Connection Error');
    }

    statusRequest = StatusRequest.success;
    update();
  }

  Future<int> getUserReadTimeData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await userSettingData.getUserSettingData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        UserSettingModel res = UserSettingModel.fromJson(response);
        userSettingModel = res.userSetting![0];

        await resetTimeWithReadTime();

        statusRequest = StatusRequest.success;
      } else {
        Get.snackbar('Warning', 'Auth Error');
      }
    } else {
      Get.snackbar('Warning', 'Server Error');
    }

    statusRequest = StatusRequest.success;
    update();
    return userSettingModel.readTime!;
  }

  resetTimeWithReadTime() async {
    InverterDataController inverterDataController = Get.find();
    inverterDataController.timer.cancel();
    inverterDataController.readTime = await getUserSettingData();
    await inverterDataController.getTimer();
  }

  Future<int> getUserSettingData() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await userSettingData.getUserSettingData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        UserSettingModel res = UserSettingModel.fromJson(response);
        userSettingModel = res.userSetting![0];
        statusRequest = StatusRequest.success;
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'auth error',
          ),
        );
      }
    } else {
      Get.snackbar('Warning', 'Server Error');
      statusRequest = StatusRequest.failure;
    }
    statusRequest = StatusRequest.success;
    update();
    return userSettingModel.readTime!;
  }

  Future setUserSettingData(
    String readTime,
    String homeName,
    String lastReadingsAvg,
    String solarPanels,
    String singleSolarMaxPower,
  ) async {
    if (readTime == '') {
      readTime = userSettingModel.readTime.toString();
    }
    if (homeName == '') {
      homeName = userSettingModel.homeName.toString();
    }
    if (lastReadingsAvg == '') {
      lastReadingsAvg = userSettingModel.lastReadingsAvg.toString();
    }

    statusRequest = StatusRequest.loading;
    update();
    var response = await userSettingEdit.editUserSettingsData(
      token: myServices.sharedPreferences.getString('token').toString(),
      body: {
        'read_time': readTime,
        // 'breaker_limit': breakerLimit,
        'home_name': homeName,
        'last_readings_avg': lastReadingsAvg,
        'solar_panels': solarPanels,
        'single_solar_max_power': singleSolarMaxPower
      },
    );
    print('==============    setUserSettingData   =====================');
    print(response);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        UserSettingModel res = UserSettingModel.fromJson(response);
        userSettingModel2 = res.userSetting![0];
        Get.snackbar('Update', 'you change settings');
        await getUserSettingData();
      } else {
        Get.snackbar('Warring', response['Message']);
      }
    } else {
      Get.snackbar('Warring', 'Server Error');

      statusRequest = StatusRequest.failure;
    }
    update();
  }

  // getData() async {
  //   await getUserSettingData();
  //   await getUserReadTimeData();
  // }

  toUserSettingPage() async {
    await initMethod();
    Get.toNamed(AppPages.userSettingPage);
  }

  Future back() async {
    Get.back();
  }
}
