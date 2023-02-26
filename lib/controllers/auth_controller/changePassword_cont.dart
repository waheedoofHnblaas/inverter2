import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth-remote/changePassword.dart';
import '../../views/widgets/apploginbutton.dart';


class ChangePasswordController extends GetxController {
  late TextEditingController password1 = TextEditingController();
  late TextEditingController password2 = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  late bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final ChangePasswordData changePasswordData = ChangePasswordData(Get.find());
  MyServices myServices = Get.find();

  changeShow() {
    showText = !showText;
    update();
  }

  Future<void> changePassword() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await changePasswordData.changePasswordData(
      new_password1: password1.text,
      new_password2: password2.text,
      token: myServices.sharedPreferences.getString('token').toString(),
      normal: false,
    );
    print(response);
    statusRequest = handlingData(response);

    if (statusRequest == StatusRequest.success) {
      if (response['detail'].toString().contains('has been saved')) {
        print(response['detail']);
        myServices.sharedPreferences.setString('password', password1.text);
      }
      Get.defaultDialog(
          title: 'Warning',
          middleText: response['detail'],
          backgroundColor: Get.theme.backgroundColor,
          actions: [
            AppSignUpAndLoginButton(
                text: 'back to main',
                onPressed: () {
                  Get.back();
                  Get.back();
                })
          ]);
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
