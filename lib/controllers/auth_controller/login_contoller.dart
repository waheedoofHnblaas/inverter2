import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:invertar_us/controllers/home_controllers/system_user_controller.dart';
import 'package:invertar_us/links.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth-remote/login.dart';
import '../../data/datasource/remote/data-remote/resetData.dart';
import '../../route.dart';

abstract class LoginController extends GetxController {
  login();

  toRegister();
}

class LoginControllerImp extends LoginController {
  TextEditingController username = TextEditingController();
  TextEditingController link =
      TextEditingController(text: 'http://0.0.0.0:8000');
  late TextEditingController password = TextEditingController();
  late TextEditingController serialNumber = TextEditingController();
  late GlobalKey<FormState> formState = GlobalKey<FormState>();
  late bool showText = true;
  StatusRequest? statusRequest = StatusRequest.none;
  final LoginData loginData = LoginData(Get.find());
  MyServices myServices = Get.find();

  List<List> keys = [];

  @override
  void onInit() async {
    myServices.sharedPreferences.getKeys().forEach((key) {
      if (key.contains('homey')) {
        keys.add(myServices.sharedPreferences.getStringList(key)!);
      }
    });
    update();
    if (myServices.sharedPreferences.getString('username') != null) {
      username = TextEditingController(
        text: myServices.sharedPreferences.getString('username').toString(),
      );
      password = TextEditingController(
        text: myServices.sharedPreferences.getString('password').toString(),
      );
      link = TextEditingController(
        text: myServices.sharedPreferences.getString('link').toString(),
      );

      update();
      await login();
    }
    super.onInit();
  }

  changeShow() {
    showText = !showText;
    update();
  }

  @override
  login() async {
    print(keys);
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
  void dispose() {
    username.dispose();
    password.dispose();
    showText = true;
    super.dispose();
  }

  Future<void> prep() async {
    {
      serverLinkHost = link.text;
      statusRequest = StatusRequest.loading;
      update();
      Timer(const Duration(seconds: 15), () {
        if (statusRequest == StatusRequest.loading) {
          statusRequest = StatusRequest.failure;
          update();
          Get.snackbar('Warning', 'timeout');

          return;
        }
      });
      var response = await loginData.loginData(
        username: username.text,
        password: password.text,
      );
      statusRequest = handlingData(response);

      print(statusRequest);
      if (statusRequest == StatusRequest.success) {
        print('login response success');

        if (response['key'] != null) {
          await myServices.sharedPreferences
              .setString('token', response['key']);
          await myServices.sharedPreferences
              .setString('username', username.text);
          await myServices.sharedPreferences
              .setString('password', password.text);
          await myServices.sharedPreferences.setString('link', link.text);
          print(response['key']);
          SystemUserControllerImp().username = SystemUserControllerImp()
              .myServices
              .sharedPreferences
              .get('username')
              .toString();
          Get.put(SystemUserControllerImp());
          Get.offNamed(AppPages.systemData);
        } else {
          Get.showSnackbar(
            GetSnackBar(
              title: response['non_field_errors'][0] ?? '',
            ),
          ).show();
        }
      } else {
        Get.snackbar('Warning', 'Connection Error');

        statusRequest = StatusRequest.failure;
      }

      update();
      print('validate');
    }
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
        // logout();
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

  setAuthValues(severLink, serverUserName, serverPassword) async {
    link = TextEditingController(text: severLink);
    username = TextEditingController(text: serverUserName);
    password = TextEditingController(text: serverPassword);
    await login();
  }
}
