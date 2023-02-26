import 'package:flutter/material.dart';
import 'package:get/get.dart';


import '../../../controllers/auth_controller/login_contoller.dart';
import '../../../core/class/handelingview.dart';
import '../../../core/function/validinput.dart';
import '../../widgets/apploginbutton.dart';
import '../../widgets/appsliverappbar.dart';
import '../../widgets/apptextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => LoginControllerImp(),
      fenix: true,
    );

    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LoginControllerImp>(builder: (controller) {
          return HandelingRequest(
            statusRequest: controller.statusRequest!,
            widget: Center(
              child: Form(
                key: controller.formState,
                child: CustomScrollView(
                  slivers: [
                    const AppSliverAppBar(title: 'Login'),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        addAutomaticKeepAlives: true,
                        semanticIndexOffset: 100,
                        [
                          const SizedBox(
                            height: 150,
                          ),
                          AppTextField(
                            textFieldController:controller.username,

                            type: 'username',
                            iconData: Icons.person,
                            inputType: TextInputType.name,
                            onChanged: (val) {},
                            validator: (val) {
                              controller.username =
                                  TextEditingController(text: val);
                              return validInput(val!, 4, 20, 'username');
                            },
                          ),
                          GetBuilder<LoginControllerImp>(builder: (controller) {
                            return AppTextField(
                              textFieldController: controller.password,
                              obscureText: controller.showText,
                              onTap: () {
                                controller.changeShow();
                              },
                              validator: (val) {
                                controller.password =
                                    TextEditingController(text: val);
                                return validInput(val!, 8, 50, 'password');
                              },
                              // controller: controller.password,
                              type: 'Password',
                              iconData: controller.showText
                                  ? Icons.remove_red_eye_outlined
                                  : Icons.password_outlined,
                              inputType: TextInputType.visiblePassword,
                              onChanged: (val) {},
                            );
                          }),
                          AppSignUpAndLoginButton(
                            text: 'login',
                            onPressed: () async {
                              await controller.login();
                            },
                          ),
                          // AppLoginSignUp(
                          //   textone: 'you don\'t have account ?',
                          //   texttwo: 'sign up',
                          //   onPressed: () {
                          //     controller.toRegister();
                          //   },
                          // )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
