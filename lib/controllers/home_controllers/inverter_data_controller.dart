import 'package:get/get.dart';
import 'package:invertar_us/core/class/statusrequest.dart';
import 'package:invertar_us/core/function/handlingdata.dart';
import 'package:invertar_us/core/services/services.dart';
import 'package:invertar_us/data/datasource/remote/data-remote/getDataInfo.dart';
import 'package:invertar_us/data/model/dataInfoModel.dart';

class InverterDataController extends GetxController {
  StatusRequest statusRequest = StatusRequest.loading;
  final InfoData infoData = InfoData(Get.find());
  MyServices myServices = Get.find();
  String username = '';

  List<Map<String, dynamic>> dataList = [];
  List<Map<String, dynamic>> faultsList = [];

  @override
  void onInit() {
    getInfoData();
    super.onInit();
  }

  Future getInfoData() async {
    dataList.clear();
    faultsList.clear();
    statusRequest = StatusRequest.loading;
    update();
    Map<String, dynamic> response = await infoData.getInfoData(
      token: myServices.sharedPreferences.getString('token').toString(),
    );
    // print('===========getInfoData====response========');
    // print(response);
    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success'] != null) {
        print('==========getInfoData====batteryChargingCurrent=======');

        DataListModel.fromJson(response['data List'][0])
            .data!
            .toJson()
            .forEach((key, value) {
          dataList.add({key: value});
        });
        DataListModel.fromJson(response['data List'][0])
            .faults!
            .toJson()
            .forEach((key, value) {
          faultsList.add({key: value});
        });
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
    // dataModel = DataModel.fromJson(AppStaticData.data);

    update();
  }
}
