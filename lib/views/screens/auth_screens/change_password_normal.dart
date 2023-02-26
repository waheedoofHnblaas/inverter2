import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/auth_controller/changePasswordNormal_cont.dart';
import '../../../core/class/handelingview.dart';
import '../../../core/function/validinput.dart';
import '../../widgets/apploginbutton.dart';
import '../../widgets/appsliverappbar.dart';
import '../../widgets/apptextfield.dart';

class ChangePasswordNormalPage extends StatelessWidget {
  const ChangePasswordNormalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(
      () => ChangePasswordNormalController(),
      fenix: true,
    );

    return Scaffold(
      body: SafeArea(
        child:
            GetBuilder<ChangePasswordNormalController>(builder: (controller) {
          return HandelingRequest(
            statusRequest: controller.statusRequest!,
            widget: Center(
              child: Form(
                key: controller.formState,
                child: CustomScrollView(
                  slivers: [
                    const AppSliverAppBar(title: 'Change Password Normal User'),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        addAutomaticKeepAlives: true,
                        semanticIndexOffset: 100,
                        [
                          const SizedBox(
                            height: 150,
                          ),
                          GetBuilder<ChangePasswordNormalController>(
                              builder: (controller) {
                            return AppTextField(
                              textFieldController: controller.password1,
                              obscureText: controller.showText,
                              onTap: () {
                                controller.changeShow();
                              },
                              validator: (val) {
                                controller.password1 =
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
                          GetBuilder<ChangePasswordNormalController>(
                              builder: (controller) {
                            return AppTextField(
                              textFieldController: controller.password2,
                              obscureText: controller.showText,
                              onTap: () {
                                controller.changeShow();
                              },
                              validator: (val) {
                                controller.password2 =
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
                            text: 'change Password',
                            onPressed: () async {
                              await controller.changePassword();
                            },
                          ),
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
