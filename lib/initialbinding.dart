import 'package:get/get.dart';
import 'controllers/auth_controller/login_contoller.dart';
import 'core/class/crud.dart';


class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Crud());
    Get.put(LoginControllerImp());

  }
}
