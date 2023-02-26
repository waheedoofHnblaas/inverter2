import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth-remote/registerationUser.dart';


class RegisterControllerImp extends GetxController {
  TextEditingController username = TextEditingController();
  late TextEditingController password = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  late bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final RegistrationData registrationData = RegistrationData(Get.find());
  MyServices myServices = Get.find();

  changeShow() {
    showText = !showText;
    update();
  }

  Future<void> register() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await registrationData.registrationData(
      token: myServices.sharedPreferences.getString('token').toString(),
      username: username.text,
      password: password.text,
    );
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success'] == true) {
        print('success registration');
        Get.back();
      } else {
        print(response['Message']);
      }
      Get.defaultDialog(
        title: 'Warning',
        middleText: response['Message'],
        backgroundColor: Get.theme.backgroundColor,
      );
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
}
