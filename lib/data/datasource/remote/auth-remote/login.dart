import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class LoginData {
  Crud crud;

  LoginData(this.crud);

  loginData({
    required String username,
    required String password,
  }) async {
    var response = await crud.postData(
      AppLinks.loginLink,
      {
        'Cookie':
            'csrftoken=tG4ZCRwxd5EMcHrk2oXBsUmpeY2DEs8u; sessionid=pgly2nidpuviqmn5plv2573k4sjqok7w'
      },
      {'password': password, 'username': username},
    );
    return response.fold((l) => l, (r) => r);
  }
}
