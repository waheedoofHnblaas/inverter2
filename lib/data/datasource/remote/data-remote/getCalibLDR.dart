import '../../../../core/class/crud.dart';
import '../../../../links.dart';

class CalibLDRData {
  Crud crud;

  CalibLDRData(this.crud);

  getCalibLDRData({required String token}) async {
    var response = await crud.getData(
      serverLinkHost+calibrate_ldr_sensor,
      {
        'Authorization': 'Token $token',
        'Cookie':
        'csrftoken=425BcoYPbadJEYItBcap8HsevewsKj2a; sessionid=pgly2nidpuviqmn5plv2573k4sjqok7w',
      },
    );
    return response.fold((l) => l, (r) => r);
  }
}
