import 'package:get/get.dart';

import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/data-remote/getUserSetting.dart';
import '../../data/model/userSettingModel.dart';

class UserSettingController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  final UserSettingData userSettingData = UserSettingData(Get.find());
  MyServices myServices = Get.find();
  UserSetting userSettingModel = UserSetting();

  @override
  void onInit() {
    getUserSettingData();
    super.onInit();
  }

  Future getUserSettingData() async {
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> response = await userSettingData.getUserSettingData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    print('getUserSettingData');
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        UserSettingModel res = UserSettingModel.fromJson(response);
        userSettingModel = res.userSetting![0];
      } else {
        Get.showSnackbar(
          const GetSnackBar(
            title: 'auth error',
          ),
        );
      }
    } else {
      Get.defaultDialog(
        title: 'Warning',
        middleText: 'server error',
        backgroundColor: Get.theme.backgroundColor,
      );
      statusRequest = StatusRequest.failure;
    }
    update();
  }
}
