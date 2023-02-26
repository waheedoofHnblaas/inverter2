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
  int? breakerLimit;
  int? inverterSerialNumber;
  String? homeName;
  String? lastEdit;

  UserSetting(
      {this.id,
        this.inverterType,
        this.readTime,
        this.lastReadingsAvg,
        this.breakerLimit,
        this.inverterSerialNumber,
        this.homeName,
        this.lastEdit});

  UserSetting.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    inverterType = json['inverter_type'];
    readTime = json['read_time'];
    lastReadingsAvg = json['last_readings_avg'];
    breakerLimit = json['breaker_limit'];
    inverterSerialNumber = json['inverter_serial_number'];
    homeName = json['home_name'];
    lastEdit = json['last_edit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['inverter_type'] = inverterType;
    data['read_time'] = readTime;
    data['last_readings_avg'] = lastReadingsAvg;
    data['breaker_limit'] = breakerLimit;
    data['inverter_serial_number'] = inverterSerialNumber;
    data['home_name'] = homeName;
    data['last_edit'] = lastEdit;
    return data;
  }
}