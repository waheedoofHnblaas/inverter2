import 'dart:convert';

import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class EditInverterSettingsData {
  Crud crud;

  EditInverterSettingsData(this.crud);

  editInverterSettingsData({required String token, required Map body}) async {
    var response = await crud.putData(
      serverLinkHost+seditInverterSetting,
      {
        'Authorization': 'Token $token',
        'Content-Type': 'application/json',
        'Cookie': 'csrftoken=1lQwVxWsWXoao4OUdCWyfX87m9gGksT3; sessionid=aykdpym5o15klcxccc5niedia86wfug5'
      },
      jsonEncode(body),
    );
    return response.fold((l) => l, (r) => r);
  }
}
