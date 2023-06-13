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
  Map<String, dynamic> inverterSettingsMap ={};
  List<dynamic> editInverterSettingsMap = [];
  bool showEdit = false;

  @override
  Future<void> onInit() async {
    print('InverterSettingsController');
    print('=======================================');
    await getSettingsData();
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
    var response = await inverterSettingsData.getInverterSettingsData(
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
        Get.snackbar('Warring', 'auth error');

      }
    } else {
      Get.snackbar('Warring', 'server error');

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
    print(statusRequest);

    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        statusRequest = StatusRequest.success;
        await getSettingsData();
        Get.snackbar('Update', 'you change settings');
        Get.back();
      } else {
        Get.snackbar('Warring', response['Message']);
      }
    } else {

      Get.snackbar('Warning',  'server error',);

      statusRequest = StatusRequest.failure;
    }
    update();
  }
}
