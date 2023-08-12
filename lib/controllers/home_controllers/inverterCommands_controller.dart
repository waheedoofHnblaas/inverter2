import 'dart:async';

import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/data-remote/getInverterCommands.dart';
import '../../data/model/inverterCommandsModel.dart';

class InverterCommandsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  final InverterCommandsData inverterCommandsData =
      InverterCommandsData(Get.find());
  MyServices myServices = Get.find();
  InverterSettingsController inverterSettingsController = Get.find();
  List<CommandModel> inverterCommandsList = [];

  // List<CommandModel> commandOfSettingsList = [];

  @override
  Future<void> onInit() async {
    await getCommandsData();
    super.onInit();
  }



  Future getCommandsData() async {
    inverterCommandsList.clear();
    statusRequest = StatusRequest.loading;
    update();
    Map<dynamic, dynamic> response =
        await inverterCommandsData.getInverterCommandsData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    print('===========getInfoData====response========');
    print(response);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        List list = InverterCommandsModel.fromJson(response).commandsList!;
        for (CommandModel command in list) {
          inverterSettingsController.inverterSettingsMap.forEach((key, value) {
            if (command.commandShortcutInSettings == key) {
              inverterCommandsList.add(command);
            }
          });
        }
      } else {
        Get.snackbar(
          'Warning',
          'auth error',
        );
      }
    } else {
      Get.snackbar('Warning', 'server error');
    }
    print('getCommandsData');
    statusRequest = StatusRequest.success;
    update();
  }
}
