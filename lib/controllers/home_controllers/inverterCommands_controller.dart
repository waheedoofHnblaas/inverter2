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
        // {
        //   "Success": true,
        //   "command List": [
        //     {
        //       "id": 2073,
        //       "command_shortcut": "F",
        //       "command_shortcut_in_settings": "ac_output_frequency",
        //       "command_number_in_catelog": "9",
        //       "command_description": "Set Device Output Frequency -- examples: F50 (set output frequency to 50Hz) or F60 (set output frequency to 60Hz)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": 50,
        //         "max": 60,
        //         "choices": {}
        //       },
        //       "increamental": "10"
        //     },
        //     {
        //       "id": 2074,
        //       "command_shortcut": "MCHGC",
        //       "command_shortcut_in_settings": "max_charging_current",
        //       "command_number_in_catelog": "2",
        //       "command_description": "Set Max Charging Current (for parallel units) -- examples: MCHGC040 (set unit 0 to max charging current of 40A), MCHGC160 (set unit 1 to max charging current of 60A)",
        //       "boundries_prefix": "0",
        //       "boundries": {
        //         "min": 10,
        //         "max": 80,
        //         "choices": {}
        //       },
        //       "increamental": "10"
        //     },
        //     {
        //       "id": 2075,
        //       "command_shortcut": "MNCHGC",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set Utility Max Charging Current (more than 100A) (for 4000/5000) -- example: MNCHGC1120 (set unit 1 utility max charging current to 120A)",
        //       "boundries_prefix": "0",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2076,
        //       "command_shortcut": "MUCHGC",
        //       "command_shortcut_in_settings": "max_ac_charging_current",
        //       "command_number_in_catelog": "11",
        //       "command_description": "Set Utility Max Charging Current -- example: MUCHGC130 (set unit 1 utility max charging current to 30A)",
        //       "boundries_prefix": "0",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "2": 2,
        //           "10": 10,
        //           "20": 20,
        //           "30": 30,
        //           "40": 40,
        //           "50": 50,
        //           "60": 60
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2077,
        //       "command_shortcut": "PBCV",
        //       "command_shortcut_in_settings": "battery_recharge_voltage",
        //       "command_number_in_catelog": "12",
        //       "command_description": "Set Battery re-charge voltage -- example PBCV44.0 - set re-charge voltage to 44V (12V unit: 11V/11.3V/11.5V/11.8V/12V/12.3V/12.5V/12.8V, 24V unit: 22V/22.5V/23V/23.5V/24V/24.5V/25V/25.5V, 48V unit: 44V/45V/46V/47V/48V/49V/50V/51V)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": 22.0,
        //         "max": 25.5,
        //         "choices": {}
        //       },
        //       "increamental": "0.5"
        //     },
        //     {
        //       "id": 2078,
        //       "command_shortcut": "PBDV",
        //       "command_shortcut_in_settings": "battery_redischarge_voltage",
        //       "command_number_in_catelog": "13",
        //       "command_description": "Set Battery re-discharge voltage -- example PBDV48.0 - set re-discharge voltage to 48V (12V unit: 00.0V/12V/12.3V/12.5V/12.8V/13V/13.3V/13.5V/13.8V/14V/14.3V/14.5, 24V unit: 00.0V/24V/24.5V/25V/25.5V/26V/26.5V/27V/27.5V/28V/28.5V/29V, 48V unit: 00.0V/48V/49V/50V/51V/52V/53V/54V/55V/56V/57V/58V, 00.0V means battery is full(charging in float mode).)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": 24,
        //         "max": 29,
        //         "choices": {
        //           "full charge": "00.0"
        //         }
        //       },
        //       "increamental": "0.5"
        //     },
        //     {
        //       "id": 2079,
        //       "command_shortcut": "PBFT",
        //       "command_shortcut_in_settings": "battery_float_charge_voltage",
        //       "command_number_in_catelog": "27",
        //       "command_description": "Set Battery Float Charging Voltage -- example PBFT58.0 - set battery float charging voltage to 58V (48.0 - 58.4V for 48V unit)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": 25,
        //         "max": 31.5,
        //         "choices": {}
        //       },
        //       "increamental": "0.1"
        //     },
        //     {
        //       "id": 2080,
        //       "command_shortcut": "PBT",
        //       "command_shortcut_in_settings": "battery_type",
        //       "command_number_in_catelog": "5",
        //       "command_description": "Set Battery Type -- examples: PBT00 (set battery as AGM), PBT01 (set battery as FLOODED), PBT02 (set battery as USER)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "AGM": "00",
        //           "FLOODED": "01",
        //           "User-Defined": "02"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2081,
        //       "command_shortcut": "PCP",
        //       "command_shortcut_in_settings": "charger_source_priority",
        //       "command_number_in_catelog": "16",
        //       "command_description": "Set Device Charger Priority -- examples: PCP00 (set utility first), PCP01 (set solar first), PCP02 (HS only: set solar and utility), PCP03 (set solar only charging)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "utility first": "00",
        //           "solar first": "01",
        //           "solar and utility": "02",
        //           "solar only charging": "03"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2082,
        //       "command_shortcut": "PCVV",
        //       "command_shortcut_in_settings": "battery_bulk_charge_voltage",
        //       "command_number_in_catelog": "26",
        //       "command_description": "Set Battery C.V. (constant voltage) charging voltage -- example PCVV48.0 - set charging voltage to 48V (48.0 - 58.4V for 48V unit)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": 25,
        //         "max": 31.5,
        //         "choices": {}
        //       },
        //       "increamental": "0.1"
        //     },
        //     {
        //       "id": 2083,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "over_temperature_restart",
        //       "command_number_in_catelog": "18",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "v"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2084,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "overload_restart",
        //       "command_number_in_catelog": "23",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "u"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2085,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "lcd_reset_to_default",
        //       "command_number_in_catelog": "99",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "k"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2086,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "power_saving",
        //       "command_number_in_catelog": "19",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "j"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2087,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "overload_bypass",
        //       "command_number_in_catelog": "06",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "b"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2088,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "buzzer",
        //       "command_number_in_catelog": "07",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "a"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2089,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "record_fault_code",
        //       "command_number_in_catelog": "20",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "z"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2090,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "primary_source_interrupt_alarm",
        //       "command_number_in_catelog": "22",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "y"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2091,
        //       "command_shortcut": "PE",
        //       "command_shortcut_in_settings": "lcd_backlight",
        //       "command_number_in_catelog": "25",
        //       "command_description": "Set the enabled state of an Inverter setting -- examples: PEa - enable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "enabled": "x"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2092,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "over_temperature_restart",
        //       "command_number_in_catelog": "18",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "v"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2093,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "overload_restart",
        //       "command_number_in_catelog": "23",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "u"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2094,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "lcd_reset_to_default",
        //       "command_number_in_catelog": "99",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "k"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2095,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "power_saving",
        //       "command_number_in_catelog": "19",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "j"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2096,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "overload_bypass",
        //       "command_number_in_catelog": "06",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "b"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2097,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "buzzer",
        //       "command_number_in_catelog": "07",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "a"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2098,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "record_fault_code",
        //       "command_number_in_catelog": "20",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "z"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2099,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "primary_source_interrupt_alarm",
        //       "command_number_in_catelog": "22",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "y"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2100,
        //       "command_shortcut": "PD",
        //       "command_shortcut_in_settings": "lcd_backlight",
        //       "command_number_in_catelog": "25",
        //       "command_description": "Set the disabled state of an Inverter setting -- examples: PDa - disable a (buzzer) [a=buzzer, b=overload bypass, j=power saving, K=LCD go to default after 1min, u=overload restart, v=overtemp restart, x=backlight, y=alarm on primary source interrupt, z=fault code record]",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "disabled": "x"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2101,
        //       "command_shortcut": "PF",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set Control Parameters to Default Values -- example PF (reset control parameters to defaults)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2102,
        //       "command_shortcut": "PGR",
        //       "command_shortcut_in_settings": "input_voltage_range",
        //       "command_number_in_catelog": "3",
        //       "command_description": "Set Grid Working Range -- examples: PCR00 (set device working range to appliance), PCR01 (set device working range to UPS)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "appliance": "00",
        //           "UPS": "01"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2103,
        //       "command_shortcut": "POP",
        //       "command_shortcut_in_settings": "output_source_priority",
        //       "command_number_in_catelog": "1",
        //       "command_description": "Set Device Output Source Priority -- examples: POP00 (set utility first), POP01 (set solar first), POP02 (set SBU priority)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {
        //           "set utility first": "00",
        //           "set solar first": "01",
        //           "set SBU priority": "02"
        //         }
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2104,
        //       "command_shortcut": "POPLG",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set Device Operation Logic -- examples: POPLG00 (set Auto mode), POPLG01 (set Online mode), POPLG02 (set ECO mode)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2105,
        //       "command_shortcut": "POPM",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set Device Output Mode (for 4000/5000) -- examples: POPM01 (set unit 0 to 1 - parallel output), POPM10 (set unit 1 to 0 - single machine output), POPM02 (set unit 0 to 2 - phase 1 of 3), POPM13 (set unit 1 to 3 - phase 2 of 3), POPM24 (set unit 2 to 4 - phase 3 of 3)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2106,
        //       "command_shortcut": "PPCP",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set Parallel Device Charger Priority (for 4000/5000) -- examples: PPCP000 (set unit 1 to 00 - utility first), PPCP101 (set unit 1 to 01 - solar first), PPCP202 (set unit 2 to 02 - solar and utility), PPCP003 (set unit 0 to 03 - solar only charging)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2107,
        //       "command_shortcut": "PPVOKC",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set PV OK Condition -- examples: PPVOKC0 (as long as one unit has connected PV, parallel system will consider PV OK), PPVOKC1 (only if all inverters have connected PV, parallel system will consider PV OK)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2108,
        //       "command_shortcut": "PSDV",
        //       "command_shortcut_in_settings": "battery_under_voltage",
        //       "command_number_in_catelog": "29",
        //       "command_description": "Set Battery Cut-off Voltage -- example PSDV40.0 - set battery cut-off voltage to 40V (40.0 - 48.0V for 48V unit)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": 21,
        //         "max": 24,
        //         "choices": {}
        //       },
        //       "increamental": "0.1"
        //     },
        //     {
        //       "id": 2109,
        //       "command_shortcut": "PSPB",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set Solar Power Balance -- examples: PSPB0 (PV input max current will be the max charged current), PSPB1 (PV input max power will be the sum of the max charge power and loads power)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2110,
        //       "command_shortcut": "PBATCD",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Battery charge/discharge controlling command -- examples: PBATCDxxx (please read description, use carefully)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2111,
        //       "command_shortcut": "DAT",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Set Date Time -- examples: DATYYYYMMDDHHMMSS (14 digits after DAT)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2112,
        //       "command_shortcut": "PBATMAXDISC",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Battery max discharge current -- examples: PBATMAXDISCxxx (000- disable or 030-150A)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2113,
        //       "command_shortcut": "Q1",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Q1 query",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2114,
        //       "command_shortcut": "QBOOT",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "DSP Has Bootstrap inquiry",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2115,
        //       "command_shortcut": "QDI",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Default Settings inquiry -- queries the default settings from the Inverter",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2116,
        //       "command_shortcut": "QFLAG",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Flag Status inquiry -- queries the enabled / disabled state of various Inverter settings (e.g. buzzer, overload, interrupt alarm)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2117,
        //       "command_shortcut": "QID",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Device Serial Number inquiry -- queries the device serial number",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2118,
        //       "command_shortcut": "QMCHGCR",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Max Charging Current Options inquiry -- queries the maximum charging current setting of the Inverter",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2119,
        //       "command_shortcut": "QMOD",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Mode inquiry -- queries the Inverter mode",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2120,
        //       "command_shortcut": "QMUCHGCR",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Max Utility Charging Current Options inquiry -- queries the maximum utility charging current setting of the Inverter",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2121,
        //       "command_shortcut": "QOPM",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Output Mode inquiry -- queries the output mode of the Inverter (e.g. single, parallel, phase 1 of 3 etc)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2122,
        //       "command_shortcut": "QPGS",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Parallel Information inquiry -- example: QPGS1 queries the values of various metrics from instance 1 of parallel setup Inverters (numbers from 0)",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2123,
        //       "command_shortcut": "QPI",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Protocol ID inquiry -- queries the device protocol ID. e.g. PI30 for HS series",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2124,
        //       "command_shortcut": "QPIGS",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "General Status Parameters inquiry -- queries the value of various metrics from the Inverter",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2125,
        //       "command_shortcut": "QPIRI",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Current Settings inquiry -- queries the current settings from the Inverter",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2126,
        //       "command_shortcut": "QPIWS",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Warning status inquiry -- queries any active warnings flags from the Inverter",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2127,
        //       "command_shortcut": "QVFW",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Main CPU firmware version inquiry -- queries the main CPU firmware version",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     },
        //     {
        //       "id": 2128,
        //       "command_shortcut": "QVFW2",
        //       "command_shortcut_in_settings": "None",
        //       "command_number_in_catelog": "None",
        //       "command_description": "Secondary CPU firmware version inquiry -- queries the secondary CPU firmware version",
        //       "boundries_prefix": "None",
        //       "boundries": {
        //         "min": null,
        //         "max": null,
        //         "choices": {}
        //       },
        //       "increamental": "0"
        //     }
        //   ]
        // };

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
              print(command.commandShortcutInSettings);
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
