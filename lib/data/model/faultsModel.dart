
class FaultsModel {
  String? sCommand;
  String? sCommandDescription;
  String? inverterFault;
  String? busOverFault;
  String? busUnderFault;
  String? busSoftFailFault;
  String? lineFailWarning;
  String? opvShortWarning;
  String? inverterVoltageTooLowFault;
  String? inverterVoltageTooHighFault;
  String? overTemperatureFault;
  String? fanLockedFault;
  String? batteryVoltageToHighFault;
  String? batteryLowAlarmWarning;
  String? reserved;
  String? batteryUnderShutdownWarning;
  String? overloadFault;
  String? eepromFault;
  String? inverterOverCurrentFault;
  String? inverterSoftFailFault;
  String? selfTestFailFault;
  String? opDcVoltageOverFault;
  String? batOpenFault;
  String? currentSensorFailFault;
  String? batteryShortFault;
  String? powerLimitWarning;
  String? pvVoltageHighWarning;
  String? mpptOverloadFault;
  String? mpptOverloadWarning;
  String? batteryTooLowToChargeWarning;
  String? createAt;

  FaultsModel(
      {this.sCommand,
        this.sCommandDescription,
        this.inverterFault,
        this.busOverFault,
        this.busUnderFault,
        this.busSoftFailFault,
        this.lineFailWarning,
        this.opvShortWarning,
        this.inverterVoltageTooLowFault,
        this.inverterVoltageTooHighFault,
        this.overTemperatureFault,
        this.fanLockedFault,
        this.batteryVoltageToHighFault,
        this.batteryLowAlarmWarning,
        this.reserved,
        this.batteryUnderShutdownWarning,
        this.overloadFault,
        this.eepromFault,
        this.inverterOverCurrentFault,
        this.inverterSoftFailFault,
        this.selfTestFailFault,
        this.opDcVoltageOverFault,
        this.batOpenFault,
        this.currentSensorFailFault,
        this.batteryShortFault,
        this.powerLimitWarning,
        this.pvVoltageHighWarning,
        this.mpptOverloadFault,
        this.mpptOverloadWarning,
        this.batteryTooLowToChargeWarning,
        this.createAt});

  FaultsModel.fromJson(Map<String, dynamic> json) {
    sCommand = json['_command'];
    sCommandDescription = json['_command_description'];
    inverterFault = json['inverter_fault'];
    busOverFault = json['bus_over_fault'];
    busUnderFault = json['bus_under_fault'];
    busSoftFailFault = json['bus_soft_fail_fault'];
    lineFailWarning = json['line_fail_warning'];
    opvShortWarning = json['opv_short_warning'];
    inverterVoltageTooLowFault = json['inverter_voltage_too_low_fault'];
    inverterVoltageTooHighFault = json['inverter_voltage_too_high_fault'];
    overTemperatureFault = json['over_temperature_fault'];
    fanLockedFault = json['fan_locked_fault'];
    batteryVoltageToHighFault = json['battery_voltage_to_high_fault'];
    batteryLowAlarmWarning = json['battery_low_alarm_warning'];
    reserved = json['reserved'];
    batteryUnderShutdownWarning = json['battery_under_shutdown_warning'];
    overloadFault = json['overload_fault'];
    eepromFault = json['eeprom_fault'];
    inverterOverCurrentFault = json['inverter_over_current_fault'];
    inverterSoftFailFault = json['inverter_soft_fail_fault'];
    selfTestFailFault = json['self_test_fail_fault'];
    opDcVoltageOverFault = json['op_dc_voltage_over_fault'];
    batOpenFault = json['bat_open_fault'];
    currentSensorFailFault = json['current_sensor_fail_fault'];
    batteryShortFault = json['battery_short_fault'];
    powerLimitWarning = json['power_limit_warning'];
    pvVoltageHighWarning = json['pv_voltage_high_warning'];
    mpptOverloadFault = json['mppt_overload_fault'];
    mpptOverloadWarning = json['mppt_overload_warning'];
    batteryTooLowToChargeWarning = json['battery_too_low_to_charge_warning'];
    createAt = json['create at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_command'] = sCommand;
    data['_command_description'] = sCommandDescription;
    data['inverter_fault'] = inverterFault;
    data['bus_over_fault'] = busOverFault;
    data['bus_under_fault'] = busUnderFault;
    data['bus_soft_fail_fault'] = busSoftFailFault;
    data['line_fail_warning'] = lineFailWarning;
    data['opv_short_warning'] = opvShortWarning;
    data['inverter_voltage_too_low_fault'] = inverterVoltageTooLowFault;
    data['inverter_voltage_too_high_fault'] = inverterVoltageTooHighFault;
    data['over_temperature_fault'] = overTemperatureFault;
    data['fan_locked_fault'] = fanLockedFault;
    data['battery_voltage_to_high_fault'] = batteryVoltageToHighFault;
    data['battery_low_alarm_warning'] = batteryLowAlarmWarning;
    data['reserved'] = reserved;
    data['battery_under_shutdown_warning'] = batteryUnderShutdownWarning;
    data['overload_fault'] = overloadFault;
    data['eeprom_fault'] = eepromFault;
    data['inverter_over_current_fault'] = inverterOverCurrentFault;
    data['inverter_soft_fail_fault'] = inverterSoftFailFault;
    data['self_test_fail_fault'] = selfTestFailFault;
    data['op_dc_voltage_over_fault'] = opDcVoltageOverFault;
    data['bat_open_fault'] = batOpenFault;
    data['current_sensor_fail_fault'] = currentSensorFailFault;
    data['battery_short_fault'] = batteryShortFault;
    data['power_limit_warning'] = powerLimitWarning;
    data['pv_voltage_high_warning'] = pvVoltageHighWarning;
    data['mppt_overload_fault'] = mpptOverloadFault;
    data['mppt_overload_warning'] = mpptOverloadWarning;
    data['battery_too_low_to_charge_warning'] =
        batteryTooLowToChargeWarning;
    data['create at'] = createAt;
    return data;
  }
}