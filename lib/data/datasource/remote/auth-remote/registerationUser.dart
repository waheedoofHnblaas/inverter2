
import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class RegistrationData {
  Crud crud;

  RegistrationData(this.crud);

  registrationData({
    required String username,
    required String password,
    required String token,
  }) async {
    var response = await crud.postData(
      AppLinks.registeration,
      {
        'Authorization': 'Token $token',
        'Cookie':
            'csrftoken=ZwHmA1NH6w0C2XW7Uf4H9jjfAHaABwne; sessionid=fpxlzwjbgv4bs358yl05dyhubebetula'
      },
      {'password': password, 'username': username},
    );
    return response.fold((l) => l, (r) => r);
  }
}
