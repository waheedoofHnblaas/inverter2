import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/auth-remote/deleteUser.dart';

class DeleteUserController extends GetxController {
  StatusRequest? statusRequest = StatusRequest.success;
  final DeleteUserData deleteUserData = DeleteUserData(Get.find());
  MyServices myServices = Get.find();

  Future<void> deleteUser() async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await deleteUserData.deleteUserData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    statusRequest = handlingData(response);
    print(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Message'].toString()!='') {
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
}
