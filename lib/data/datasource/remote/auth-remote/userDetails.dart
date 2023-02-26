import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class UserDetails {
  Crud crud;

  UserDetails(this.crud);

  userDetails({
    required String token,
  }) async {
    var response = await crud.getData(
      AppLinks.getUserDetails,
      {
        'Authorization': 'Token $token',
        'Cookie':
            'csrftoken=425BcoYPbadJEYItBcap8HsevewsKj2a; sessionid=pgly2nidpuviqmn5plv2573k4sjqok7w',
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
