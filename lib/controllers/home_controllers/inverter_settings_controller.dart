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
  List<dynamic> editInverterSettingsValuesList = [];
  // bool showEdit = false;

  @override
  Future<void> onInit() async {
    print('InverterSettingsController');
    print('=======================================');
    await getSettingsData();
    super.onInit();
  }

  resetEditSettingsMap() {
    editInverterSettingsValuesList = inverterSettingsMap.values.toList();
    update();
    print('resetEditSettingsMap');
  }

  Future getSettingsData() async {
    statusRequest = StatusRequest.loading;
    update();
    Map response =
    {
      "Success": true,
      "Inverter Settings": {
        "ac_input_voltage": 220.0,
        "ac_input_current": 13.6,
        "ac_output_voltage": 220.0,
        "ac_output_frequency": 50.0,
        "ac_output_current": 13.6,
        "ac_output_apparent_power": 3000,
        "ac_output_active_power": 3000,
        "battery_voltage": 24.0,
        "battery_recharge_voltage": 23.0,
        "battery_under_voltage": 21.5,
        "battery_bulk_charge_voltage": 29.2,
        "battery_float_charge_voltage": 27.0,
        "battery_type": "Flooded",
        "max_ac_charging_current": "20",
        "max_charging_current": 30,
        "input_voltage_range": "UPS",
        "output_source_priority": "Utility first",
        "charger_source_priority": "Solar + Utility",
        "max_parallel_units": 1,
        "machine_type": "Off Grid",
        "topology": "transformerless",
        "output_mode": "single machine output",
        "battery_redischarge_voltage": 27.0,
        "pv_ok_condition": "As long as one unit of inverters has connect PV, parallel system will consider PV OK",
        "pv_power_balance": "PV input max power will be the sum of the max charged power and loads power",
        "lcd_backlight": "enabled",
        "primary_source_interrupt_alarm": "enabled",
        "record_fault_code": "enabled",
        "buzzer": "disabled",
        "overload_bypass": "disabled",
        "power_saving": "disabled",
        "lcd_reset_to_default": "disabled",
        "overload_restart": "disabled",
        "over_temperature_restart": "disabled",
        "create at": "2023-08-10 09:18:56"
      }
    };

    // await inverterSettingsData.getInverterSettingsData(
    //   token: myServices.sharedPreferences.getString('token').toString(),
    // );

    statusRequest = handlingData(response);
    if (statusRequest == StatusRequest.success) {
      if (response['Success']) {
        inverterSettingsMap =
            InverterSettingsModel.fromJson(response['Inverter Settings'])
                .toJson();
        editInverterSettingsValuesList = inverterSettingsMap.values.toList();
       } else {
        Get.snackbar('Warring', 'auth error');

      }
    } else {
      Get.snackbar('Warring', 'server error');

      statusRequest = StatusRequest.failure;
    }
    update();
  }

  // void setEditShow(bool show) {
  //   showEdit = show;
  //
  // }

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
        Get.back();
        await getSettingsData();
        Get.snackbar('Update', 'you change settings successfully');
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
