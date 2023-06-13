import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class UserSettingData {
  Crud crud;

  UserSettingData(this.crud);

  getUserSettingData({
    required String token,
  }) async {
    print('====================${serverLinkHost+suser_setting}=========================');
    var response = await crud.getData(
      serverLinkHost+suser_setting,
      {
        'Authorization': 'Token $token',
        'Cookie':
            'csrftoken=zD0RnVIyfbliPAYeaLRBMtc3dvLPyQ3Y; sessionid=xwsrle62qpw8kriigcypji79sy8tsuto',
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
