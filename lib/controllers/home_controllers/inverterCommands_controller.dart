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
  void onInit() {
    getCommandsData();
    super.onInit();
  }

  Future getCommandsData() async {
    inverterCommandsList.clear();
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> response =
        await inverterCommandsData.getInverterCommandsData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    // print('===========getInfoData====response========');
    // print(response);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {

      if (response['Success']) {
        for (CommandModel command
            in InverterCommandsModel.fromJson(response).commandsList!) {
          inverterSettingsController.inverterSettingsMap.forEach((key, value) {
            if (command.commandShortcutInSettings == key) {
              inverterCommandsList.add(command);
            }
          });
        }
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
    print('getCommandsData');
    update();
  }


//
// bool haveCommand({required command}) {
//   bool h = false;
//   for (CommandModel com in inverterCommands.commandList!) {
//     // print(inverterCommands.commandList!.indexOf(com));
//     if (com.commandShortcutInSettings == command) {
//       if (!editAibleSettings.contains(com)) {
//         editAibleSettings.add(com);
//       }
//       h = true;
//     }
//   }
//   return h;
// }
//
// CommandModel? theCommand({required command}) {
//   CommandModel h = CommandModel(id: 0);
//   for (CommandModel com in inverterCommands.commandList!) {
//     if (com.commandShortcutInSettings == command) {
//       h = com;
//     }
//   }
//   return h;
// }
}
