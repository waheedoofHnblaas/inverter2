class DataModel {
  String? sCommand;
  String? sCommandDescription;
  double? acInputVoltage;
  double? acInputFrequency;
  double? acOutputVoltage;
  double? acOutputFrequency;
  int? acOutputApparentPower;
  int? acOutputActivePower;
  int? acOutputLoad;
  int? busVoltage;
  double? batteryVoltage;
  int? batteryChargingCurrent;
  int? batteryCapacity;
  int? inverterHeatSinkTemperature;
  double? pvInputCurrentForBattery;
  double? pvInputVoltage;
  double? batteryVoltageFromScc;
  int? batteryDischargeCurrent;
  int? isSbuPriorityVersionAdded;
  int? isConfigurationChanged;
  int? isSccFirmwareUpdated;
  int? isLoadOn;
  int? isBatteryVoltageToSteadyWhileCharging;
  int? isChargingOn;
  int? isSccChargingOn;
  int? isAcChargingOn;
  int? rsv1;
  int? rsv2;
  int? pvInputPower;
  int? isChargingToFloat;
  int? isSwitchedOn;
  int? isReserved;
  String? createAt;

  DataModel(
      {this.sCommand,
        this.sCommandDescription,
        this.acInputVoltage,
        this.acInputFrequency,
        this.acOutputVoltage,
        this.acOutputFrequency,
        this.acOutputApparentPower,
        this.acOutputActivePower,
        this.acOutputLoad,
        this.busVoltage,
        this.batteryVoltage,
        this.batteryChargingCurrent,
        this.batteryCapacity,
        this.inverterHeatSinkTemperature,
        this.pvInputCurrentForBattery,
        this.pvInputVoltage,
        this.batteryVoltageFromScc,
        this.batteryDischargeCurrent,
        this.isSbuPriorityVersionAdded,
        this.isConfigurationChanged,
        this.isSccFirmwareUpdated,
        this.isLoadOn,
        this.isBatteryVoltageToSteadyWhileCharging,
        this.isChargingOn,
        this.isSccChargingOn,
        this.isAcChargingOn,
        this.rsv1,
        this.rsv2,
        this.pvInputPower,
        this.isChargingToFloat,
        this.isSwitchedOn,
        this.isReserved,
        this.createAt});

  DataModel.fromJson(Map<String, dynamic> json) {
    sCommand = json['_command'];
    sCommandDescription = json['_command_description'];
    acInputVoltage = json['ac_input_voltage'];
    acInputFrequency = json['ac_input_frequency'];
    acOutputVoltage = json['ac_output_voltage'];
    acOutputFrequency = json['ac_output_frequency'];
    acOutputApparentPower = json['ac_output_apparent_power'];
    acOutputActivePower = json['ac_output_active_power'];
    acOutputLoad = json['ac_output_load'];
    busVoltage = json['bus_voltage'];
    batteryVoltage = json['battery_voltage'];
    batteryChargingCurrent = json['battery_charging_current'];
    batteryCapacity = json['battery_capacity'];
    inverterHeatSinkTemperature = json['inverter_heat_sink_temperature'];
    pvInputCurrentForBattery = json['pv_input_current_for_battery'];
    pvInputVoltage = json['pv_input_voltage'];
    batteryVoltageFromScc = json['battery_voltage_from_scc'];
    batteryDischargeCurrent = json['battery_discharge_current'];
    isSbuPriorityVersionAdded = json['is_sbu_priority_version_added'];
    isConfigurationChanged = json['is_configuration_changed'];
    isSccFirmwareUpdated = json['is_scc_firmware_updated'];
    isLoadOn = json['is_load_on'];
    isBatteryVoltageToSteadyWhileCharging =
    json['is_battery_voltage_to_steady_while_charging'];
    isChargingOn = json['is_charging_on'];
    isSccChargingOn = json['is_scc_charging_on'];
    isAcChargingOn = json['is_ac_charging_on'];
    rsv1 = json['rsv1'];
    rsv2 = json['rsv2'];
    pvInputPower = json['pv_input_power'];
    isChargingToFloat = json['is_charging_to_float'];
    isSwitchedOn = json['is_switched_on'];
    isReserved = json['is_reserved'];
    createAt = json['create at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_command'] = sCommand;
    data['_command_description'] = sCommandDescription;
    data['ac_input_voltage'] = acInputVoltage;
    data['ac_input_frequency'] = acInputFrequency;
    data['ac_output_voltage'] = acOutputVoltage;
    data['ac_output_frequency'] = acOutputFrequency;
    data['ac_output_apparent_power'] = acOutputApparentPower;
    data['ac_output_active_power'] = acOutputActivePower;
    data['ac_output_load'] = acOutputLoad;
    data['bus_voltage'] = busVoltage;
    data['battery_voltage'] = batteryVoltage;
    data['battery_charging_current'] = batteryChargingCurrent;
    data['battery_capacity'] = batteryCapacity;
    data['inverter_heat_sink_temperature'] = inverterHeatSinkTemperature;
    data['pv_input_current_for_battery'] = pvInputCurrentForBattery;
    data['pv_input_voltage'] = pvInputVoltage;
    data['battery_voltage_from_scc'] = batteryVoltageFromScc;
    data['battery_discharge_current'] = batteryDischargeCurrent;
    data['is_sbu_priority_version_added'] = isSbuPriorityVersionAdded;
    data['is_configuration_changed'] = isConfigurationChanged;
    data['is_scc_firmware_updated'] = isSccFirmwareUpdated;
    data['is_load_on'] = isLoadOn;
    data['is_battery_voltage_to_steady_while_charging'] =
        isBatteryVoltageToSteadyWhileCharging;
    data['is_charging_on'] = isChargingOn;
    data['is_scc_charging_on'] = isSccChargingOn;
    data['is_ac_charging_on'] = isAcChargingOn;
    data['rsv1'] = rsv1;
    data['rsv2'] = rsv2;
    data['pv_input_power'] = pvInputPower;
    data['is_charging_to_float'] = isChargingToFloat;
    data['is_switched_on'] = isSwitchedOn;
    data['is_reserved'] = isReserved;
    data['create at'] = createAt;
    return data;
  }
}