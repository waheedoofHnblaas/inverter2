import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class ResetData {
  Crud crud;

  ResetData(this.crud);

  resetData({
    required String inverterNumber,
  }) async {
    var response = await crud.postData(serverLinkHost + sresetData, {
      // 'Authorization': 'Token $token',
      'Cookie':
          'csrftoken=j8RXrWscPDhW8iDrw0Pd41sfYO62dYet; sessionid=mcgfbwmf1teqkgsvef8j41k6ybz0g4s6',
    }, {
      'inverter_serial_number': inverterNumber
    });
    return response.fold((l) => l, (r) => r);
  }
  resetSettingsData({
    required String inverterNumber,
  }) async {
    var response = await crud.postData(serverLinkHost + sresetSettingsData, {
      // 'Authorization': 'Token $token',
      'Cookie':
          'csrftoken=j8RXrWscPDhW8iDrw0Pd41sfYO62dYet; sessionid=mcgfbwmf1teqkgsvef8j41k6ybz0g4s6',
    }, {
      'inverter_serial_number': inverterNumber
    });
    return response.fold((l) => l, (r) => r);
  }

}
