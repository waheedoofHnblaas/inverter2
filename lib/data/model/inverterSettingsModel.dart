
class InverterSettingsModel {
  double? acInputVoltage;
  double? acInputCurrent;
  double? acOutputVoltage;
  double? acOutputFrequency;
  double? acOutputCurrent;
  int? acOutputApparentPower;
  int? acOutputActivePower;
  double? batteryVoltage;
  double? batteryRechargeVoltage;
  double? batteryUnderVoltage;
  double? batteryBulkChargeVoltage;
  double? batteryFloatChargeVoltage;
  String? batteryType;
  String? maxAcChargingCurrent;
  var maxChargingCurrent;
  String? inputVoltageRange;
  String? outputSourcePriority;
  String? chargerSourcePriority;
  int? maxParallelUnits;
  String? machineType;
  String? topology;
  String? outputMode;
  double? batteryRedischargeVoltage;
  String? pvOkCondition;
  String? pvPowerBalance;
  String? lcdBacklight;
  String? primarySourceInterruptAlarm;
  String? recordFaultCode;
  String? buzzer;
  String? overloadBypass;
  String? powerSaving;
  String? lcdResetToDefault;
  String? overloadRestart;
  String? overTemperatureRestart;
  String? createAt;

  InverterSettingsModel(
      {this.acInputVoltage,
      this.acInputCurrent,
      this.acOutputVoltage,
      this.acOutputFrequency,
      this.acOutputCurrent,
      this.acOutputApparentPower,
      this.acOutputActivePower,
      this.batteryVoltage,
      this.batteryRechargeVoltage,
      this.batteryUnderVoltage,
      this.batteryBulkChargeVoltage,
      this.batteryFloatChargeVoltage,
      this.batteryType,
      this.maxAcChargingCurrent,
      this.maxChargingCurrent,
      this.inputVoltageRange,
      this.outputSourcePriority,
      this.chargerSourcePriority,
      this.maxParallelUnits,
      this.machineType,
      this.topology,
      this.outputMode,
      this.batteryRedischargeVoltage,
      this.pvOkCondition,
      this.pvPowerBalance,
      this.lcdBacklight,
      this.primarySourceInterruptAlarm,
      this.recordFaultCode,
      this.buzzer,
      this.overloadBypass,
      this.powerSaving,
      this.lcdResetToDefault,
      this.overloadRestart,
      this.overTemperatureRestart,
      this.createAt});

  InverterSettingsModel.fromJson(Map<String, dynamic> json) {
    acInputVoltage = json['ac_input_voltage'];
    acInputCurrent = json['ac_input_current'];
    acOutputVoltage = json['ac_output_voltage'];
    acOutputFrequency = json['ac_output_frequency'];
    acOutputCurrent = json['ac_output_current'];
    acOutputApparentPower = json['ac_output_apparent_power'];
    acOutputActivePower = json['ac_output_active_power'];
    batteryVoltage = json['battery_voltage'];
    batteryRechargeVoltage = json['battery_recharge_voltage'];
    batteryUnderVoltage = json['battery_under_voltage'];
    batteryBulkChargeVoltage = json['battery_bulk_charge_voltage'];
    batteryFloatChargeVoltage = json['battery_float_charge_voltage'];
    batteryType = json['battery_type'];
    maxAcChargingCurrent = json['max_ac_charging_current'];
    maxChargingCurrent = json['max_charging_current'];
    inputVoltageRange = json['input_voltage_range'];
    outputSourcePriority = json['output_source_priority'];
    chargerSourcePriority = json['charger_source_priority'];
    maxParallelUnits = json['max_parallel_units'];
    machineType = json['machine_type'];
    topology = json['topology'];
    outputMode = json['output_mode'];
    batteryRedischargeVoltage = json['battery_redischarge_voltage'];
    pvOkCondition = json['pv_ok_condition'];
    pvPowerBalance = json['pv_power_balance'];
    lcdBacklight = json['lcd_backlight'];
    primarySourceInterruptAlarm = json['primary_source_interrupt_alarm'];
    recordFaultCode = json['record_fault_code'];
    buzzer = json['buzzer'];
    overloadBypass = json['overload_bypass'];
    powerSaving = json['power_saving'];
    lcdResetToDefault = json['lcd_reset_to_default'];
    overloadRestart = json['overload_restart'];
    overTemperatureRestart = json['over_temperature_restart'];
    createAt = json['create at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ac_input_voltage'] = acInputVoltage;
    data['ac_input_current'] = acInputCurrent;
    data['ac_output_voltage'] = acOutputVoltage;
    data['ac_output_frequency'] = acOutputFrequency;
    data['ac_output_current'] = acOutputCurrent;
    data['ac_output_apparent_power'] = acOutputApparentPower;
    data['ac_output_active_power'] = acOutputActivePower;
    data['battery_voltage'] = batteryVoltage;
    data['battery_recharge_voltage'] = batteryRechargeVoltage;
    data['battery_under_voltage'] = batteryUnderVoltage;
    data['battery_bulk_charge_voltage'] = batteryBulkChargeVoltage;
    data['battery_float_charge_voltage'] = batteryFloatChargeVoltage;
    data['battery_type'] = batteryType;
    data['max_ac_charging_current'] = maxAcChargingCurrent;
    data['max_charging_current'] = maxChargingCurrent;
    data['input_voltage_range'] = inputVoltageRange;
    data['output_source_priority'] = outputSourcePriority;
    data['charger_source_priority'] = chargerSourcePriority;
    data['max_parallel_units'] = maxParallelUnits;
    data['machine_type'] = machineType;
    data['topology'] = topology;
    data['output_mode'] = outputMode;
    data['battery_redischarge_voltage'] = batteryRedischargeVoltage;
    data['pv_ok_condition'] = pvOkCondition;
    data['pv_power_balance'] = pvPowerBalance;
    data['lcd_backlight'] = lcdBacklight;
    data['primary_source_interrupt_alarm'] = primarySourceInterruptAlarm;
    data['record_fault_code'] = recordFaultCode;
    data['buzzer'] = buzzer;
    data['overload_bypass'] = overloadBypass;
    data['power_saving'] = powerSaving;
    data['lcd_reset_to_default'] = lcdResetToDefault;
    data['overload_restart'] = overloadRestart;
    data['over_temperature_restart'] = overTemperatureRestart;
    data['create at'] = createAt;
    return data;
  }
}
