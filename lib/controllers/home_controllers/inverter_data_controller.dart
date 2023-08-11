import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/user_setting_controller.dart';
import 'package:invertar_us/core/class/statusrequest.dart';
import 'package:invertar_us/core/function/handlingdata.dart';
import 'package:invertar_us/core/services/services.dart';
import 'package:invertar_us/data/datasource/remote/data-remote/getDataInfo.dart';
import 'package:invertar_us/data/model/dataInfoModel.dart';

import '../../data/datasource/remote/data-remote/getCalibLDR.dart';

class InverterDataController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  final InfoData infoData = InfoData(Get.find());
  MyServices myServices = Get.find();
  String username = '';
  UserSettingController userSettingController = Get.find();
  late int readTime = 5;
  int reqIndex = 0;

  Timer timer = Timer(const Duration(seconds: 10), () {});

  List<Map<String, dynamic>> dataList1 = [];
  List<Map<String, dynamic>> faultsList1 = [];

  RxBool read = false.obs;

  double projectedPower = 0;

  @override
  void onInit() {
    getInfoData(true);
    repeatReading();
    super.onInit();
  }

  repeatReading() async {
    readTime = await userSettingController.getUserSettingData();

    print(readTime);
    timer = Timer.periodic(
      Duration(seconds: readTime),
      (t) {
        print(readTime);
        read.value = !read.value;
        getInfoData2();
      },
    );

    await getProjectedPower();
  }

  Future getInfoData2() async {
    List<Map<String, dynamic>> dataList2 = [];
    List<Map<String, dynamic>> faultsList2 = [];

    var response2 = await infoData.getInfoData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    statusRequest = handlingData(response2);
    if (statusRequest == StatusRequest.success) {
      if (response2['Success'] != null) {
        DataListModel.fromJson(response2['data List'][0])
            .data!
            .toJson()
            .forEach((key, value) {
          dataList2.add({key: value});
        });
        DataListModel.fromJson(response2['data List'][0])
            .faults!
            .toJson()
            .forEach((key, value) {
          faultsList2.add({key: value});
        });
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'auth error',
          ),
        );
      }
    } else {
      // Get.snackbar('Warning', 'Connection Error',
      //     snackStyle: SnackStyle.GROUNDED, onTap: (v) {});
      statusRequest = StatusRequest.failure;
    }
    if (dataList1.toString() == dataList2.toString() &&
        faultsList1.toString() == faultsList2.toString()) {
      print('========request $reqIndex=======');
      reqIndex++;
    } else {
      print('=========update read getInfoData=====');
      await getInfoData(false);
    }
  }

  String ss = '';

  Future getInfoData(bool showLoading) async {
    if (showLoading) {
      statusRequest = StatusRequest.loading;
      update();
    }

    Map<dynamic, dynamic> response = await infoData.getInfoData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    ss = response.toString();

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        dataList1.clear();
        faultsList1.clear();
        DataListModel.fromJson(response['data List'][0])
            .data!
            .toJson()
            .forEach((key, value) {
          // if (key == 'ac_input_voltage') {
          //   print('$key ==== $value');
          //   ac++;
          //   value += ac;
          //   print('$key ==== $value');
          // }

          dataList1.add({key: value});
        });
        DataListModel.fromJson(response['data List'][0])
            .faults!
            .toJson()
            .forEach((key, value) {
          faultsList1.add({key: value});
        });
        update();
      } else {
        Get.snackbar('Warning', 'Auth Error');
      }
    } else {
      Get.snackbar('Warning', 'Server Error');
      statusRequest = StatusRequest.failure;
    }
  }

  int currentPage = 0;

  PageController pageController = PageController();

  void changeScroller(int page) {
    print(page);
    if (page > 0) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (page == 0) {
      pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  List condsList = [];

  void add(int messageIndex) {
    if (condsList.contains(messageIndex)) {
    } else {
      condsList.add(messageIndex);
    }
    update();
  }

  void remove(int messageIndex) {
    if (condsList.contains(messageIndex)) {
      condsList.remove(messageIndex);
    }
    update();
  }

  final CalibLDRData projectedPowerData = CalibLDRData(Get.find());
  String errorLDRMessage = '';
  bool isReading = false;

  getProjectedPower2() async {
    var response = await projectedPowerData.getProjectedPowerData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    statusRequest = handlingData(response);
    isReading = !isReading;
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        errorLDRMessage = '';
        projectedPower = response['Projected Power Watt'];
      } else {
        // Get.snackbar('Warning', response['Message']);
        errorLDRMessage = response['Message'];
      }
    } else {
      // Get.snackbar('Warning', response['Message']);
      errorLDRMessage = response['Message'];
      statusRequest = StatusRequest.failure;
    }

    statusRequest = StatusRequest.success;
    update();
  }

  getProjectedPower() {
    Timer.periodic(Duration(seconds: readTime), (timer) async {
      // projectedPower = 3000 + (Random().nextInt(500) / 3);
      await getProjectedPower2();
      print('projectedPower : ');
      print(projectedPower);
    });
  }
}
