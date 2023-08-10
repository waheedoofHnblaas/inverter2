import 'dataModel.dart';
import 'faultsModel.dart';

class DataInfoModel {
  bool? success;
  List<DataListModel>? dataList;

  DataInfoModel({this.success, this.dataList});

  DataInfoModel.fromJson(Map<String, dynamic> json) {
    success = json['Success'];
    if (json['data List'] != null) {
      dataList = <DataListModel>[];
      json['data List'].forEach((v) {
        dataList!.add(DataListModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Success'] = success;
    if (dataList != null) {
      data['data List'] = dataList!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class DataListModel {
  int? id;
  DataModel? data;
  FaultsModel? faults;

  // String? createdAt;

  DataListModel({
    this.id,
    this.data,
    this.faults,
    // this.createdAt,
  });

  DataListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
    faults =
        json['faults'] != null ? FaultsModel.fromJson(json['faults']) : null;
    // createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (faults != null) {
      data['faults'] = faults!.toJson();
    }
    // data['created_at'] = createdAt;
    return data;
  }
}
