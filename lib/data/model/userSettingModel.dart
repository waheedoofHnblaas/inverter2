class UserSettingModel {
  bool? success;
  List<UserSetting>? userSetting;

  UserSettingModel({this.success, this.userSetting});

  UserSettingModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    if (json['User Setting'] != null) {
      userSetting = <UserSetting>[];
      json['User Setting'].forEach((v) {
        userSetting!.add(UserSetting.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    if (userSetting != null) {
      data['User Setting'] = userSetting!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserSetting {
  int? id;
  int? inverterType;
  int? readTime;
  int? lastReadingsAvg;
  int? inverterSerialNumber;
  int? solarPanels;
  int? singleSolarMaxPower;
  String? homeName;
  String? lastEdit;
  int? minLdr;
  int? maxLdr;

  UserSetting(
      {this.id,
        this.inverterType,
        this.readTime,
        this.lastReadingsAvg,
        this.inverterSerialNumber,
        this.solarPanels,
        this.singleSolarMaxPower,
        this.homeName,
        this.lastEdit,
        this.minLdr,
        this.maxLdr});

  UserSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inverterType = json['inverter_type'];
    readTime = json['read_time'];
    lastReadingsAvg = json['last_readings_avg'];
    inverterSerialNumber = json['inverter_serial_number'];
    solarPanels = json['solar_panels'];
    singleSolarMaxPower = json['single_solar_max_power'];
    homeName = json['home_name'];
    lastEdit = json['last_edit'];
    minLdr = json['min_ldr'];
    maxLdr = json['max_ldr'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['inverter_type'] = this.inverterType;
    data['read_time'] = this.readTime;
    data['last_readings_avg'] = this.lastReadingsAvg;
    data['inverter_serial_number'] = this.inverterSerialNumber;
    data['solar_panels'] = this.solarPanels;
    data['single_solar_max_power'] = this.singleSolarMaxPower;
    data['home_name'] = this.homeName;
    data['last_edit'] = this.lastEdit;
    data['min_ldr'] = this.minLdr;
    data['max_ldr'] = this.maxLdr;
    return data;
  }
}