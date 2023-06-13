import 'dart:convert';

import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class EditUserSettingsData {
  Crud crud;

  EditUserSettingsData(this.crud);

  editUserSettingsData({required String token, required Map body}) async {
    var response = await crud.putUserData(
      serverLinkHost+suser_settings_edite,
      {
        'Authorization': 'Token $token',
        'Cookie': 'csrftoken=WTBN5xK9Osca8w98L51ePV93vbGViOAP; sessionid=43sojj3clsfzlkslxrobkpl72djeov3n'
      },
      body,
    );
    return response.fold((l) => l, (r) => r);
  }
}
