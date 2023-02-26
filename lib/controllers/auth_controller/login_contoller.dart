import 'dart:async';

import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth-remote/login.dart';
import '../../route.dart';

abstract class LoginController extends GetxController {
  login();

  toRegister();
}

class LoginControllerImp extends LoginController {
  TextEditingController username = TextEditingController();
  late TextEditingController password = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  late bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();

  changeShow() {
    showText = !showText;
    update();
  }

  @override
  login() async {
    if (username.text.isNotEmpty) {
      print('login prep 1');
      prep();
    } else {
      if (formState.currentState!.validate()) {
        print('login prep 2');
        prep();
      } else {
        print('not validate');
      }
    }
  }

  @override
  toRegister() {
    Get.offNamed(AppPages.register);
  }

  @override
  void onInit() {
    if (myServices.sharedPreferences.getString('username') != null) {
      username = TextEditingController(
        text: myServices.sharedPreferences.getString('username').toString(),
      );
      password = TextEditingController(
        text: myServices.sharedPreferences.getString('password').toString(),
      );
      update();
      login();
    }

    super.onInit();
  }

  @override
  void dispose() {
    username.dispose();
    password.dispose();
    showText = true;
    super.dispose();
  }

  Future<void> prep() async {
    {
      statusRequest = StatusRequest.loading;
      update();

      print('login response wait ...');
      Timer(const Duration(seconds: 15), () {
        if (statusRequest == StatusRequest.loading) {
          statusRequest = StatusRequest.failure;
          update();
          Get.defaultDialog(
            title: 'Warning',
            middleText: 'server access error',
            backgroundColor: Get.theme.backgroundColor,
          );
        }
      });
      var response = await loginData.loginData(
        username: username.text,
        password: password.text,
      );
      print('login response');
      print(response);
      statusRequest = handlingData(response);
      if (statusRequest == StatusRequest.success) {
        print('login response success');

        if (response['key'] != null) {
          print('login response success key');

          myServices.sharedPreferences.setString('token', response['key']);
          myServices.sharedPreferences.setString('username', username.text);
          myServices.sharedPreferences.setString('password', password.text);
          print(response['key']);

          Get.offNamed(AppPages.systemData);
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: response['non_field_errors'][0],
            ),
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
  }
}
