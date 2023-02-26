import 'package:get/get.dart';
import 'package:invertar_us/data/datasource/remote/data-remote/editInverterSettings.dart';
import '../../core/class/statusrequest.dart';
import '../../core/function/handlingdata.dart';
import '../../core/services/services.dart';
import '../../data/datasource/remote/data-remote/getInverterSettings.dart';
import '../../data/model/inverterSettingsModel.dart';

class InverterSettingsController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  final InverterSettingsData inverterSettingsData = InverterSettingsData(
    Get.find(),
  );
  final EditInverterSettingsData editInverterSettingsData =
  EditInverterSettingsData(Get.find());
  MyServices myServices = Get.find();
  late Map<String, dynamic> inverterSettingsMap;
  late List<dynamic> editInverterSettingsMap;
  bool showEdit = false;

  @override
  void onInit() {
    print('InverterSettingsController');
    print('=======================================');
    getSettingsData();
    super.onInit();
  }

  resetEditSettingsMap() {
    editInverterSettingsMap = inverterSettingsMap.values.toList();
    update();
    print('resetEditSettingsMap');
  }

  Future getSettingsData() async {
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> response =
        await inverterSettingsData.getInverterSettingsData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        inverterSettingsMap =
            InverterSettingsModel.fromJson(response['Inverter Settings'])
                .toJson();
        editInverterSettingsMap = inverterSettingsMap.values.toList();
        ;
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

  void setEditShow(bool show) {
    showEdit = show;
  }
  Future editSettingsData(body) async {
    statusRequest = StatusRequest.loading;
    update();
    var response = await editInverterSettingsData.editInverterSettingsData(
      token: myServices.sharedPreferences.getString('token').toString(),
      body: body,
    );
    // print('===========getInfoData====response========');
    // print(response);
    statusRequest = handlingData(response);
    print(response);

    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        statusRequest = StatusRequest.success;
        Get.showSnackbar(
          GetSnackBar(
            message: 'update has done',
            duration: const Duration(seconds: 5),
            onTap: (snack) {
              Get.back();
            },
          ),
        );
        Get.back();
        //  getSettingsInfoData();
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
