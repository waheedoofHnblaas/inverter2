import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class ChangePasswordData {
  Crud crud;

  ChangePasswordData(this.crud);

  changePasswordData({
    required String new_password1,
    required String new_password2,
    required String token,
    required bool normal,
  }) async {
    var response = await crud.postData(
      normal ? AppLinks.change_password_normal : AppLinks.change_password,
      {
        'Authorization': 'Token $token',
        'Cookie':
            'csrftoken=m80zbxM7GWrNhxUdXq6F07pySYzs9UOr; sessionid=gif8fqunrqac71ryg4oenfox0t3l6plj'
      },
      {
        'new_password1': new_password1,
        'new_password2': new_password2,
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
