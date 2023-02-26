import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class DeleteUserData {
  Crud crud;

  DeleteUserData(this.crud);

  deleteUserData({
    required String token,
  }) async {
    var response = await crud.deleteData(
      AppLinks.delete_user,
      {
        'Authorization': 'Token $token',
        'Cookie':
            'csrftoken=j8RXrWscPDhW8iDrw0Pd41sfYO62dYet; sessionid=mcgfbwmf1teqkgsvef8j41k6ybz0g4s6',
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
