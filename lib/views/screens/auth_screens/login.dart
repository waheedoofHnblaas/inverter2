import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/system_user_controller.dart';
import 'package:invertar_us/core/class/statusrequest.dart';
import 'package:invertar_us/links.dart';

import '../../../controllers/auth_controller/login_contoller.dart';
import '../../../controllers/home_controllers/user_setting_controller.dart';
import '../../../core/class/handelingview.dart';
import '../../../core/function/validinput.dart';
import '../../widgets/apploginbutton.dart';
import '../../widgets/appsliverappbar.dart';
import '../../widgets/apptextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GetBuilder<LoginControllerImp>(builder: (controller) {
          return HandelingRequest(
            statusRequest: controller.statusRequest!,
            widget: Center(
              child: Form(
                key: controller.formState,
                child: CustomScrollView(
                  scrollDirection: Axis.vertical,
                  slivers: [
                    // SizedBox(height: Get.height/10,),
                    const AppSliverAppBar(title: 'Login'),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        addAutomaticKeepAlives: true,
                        semanticIndexOffset: 100,
                        [
                          // IconButton(
                          //   onPressed: () async {
                          //     await controller.myServices.sharedPreferences
                          //         .clear();
                          //   },
                          //   icon: const Icon(Icons.delete_outline),
                          // ),
                          // const SizedBox(
                          //   height: 150,
                          // ),
                          AppTextField(
                            onSubmit: () async {
                              print('object');
                              await controller.login();
                            },
                            textFieldController: controller.link,
                            type: 'link',
                            iconData: Icons.link,
                            inputType: TextInputType.text,
                            onChanged: (val) {
                              return null;
                            },
                            validator: (val) {
                              print('save: $val');
                              controller.myServices.sharedPreferences
                                  .setString('link', val!);
                              controller.link =
                                  TextEditingController(text: val);

                              return validInput(val, 8, 50, 'password');
                            },
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          AppTextField(
                            onSubmit: () async {},
                            textFieldController: controller.username,
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
                              onSubmit: () async {
                                await controller.login();
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

                          InkWell(
                            onTap: () async {
                              Get.defaultDialog(
                                title: 'type inverter serial number',
                                onConfirm: () async {
                                  Get.back();
                                  await controller.reset(
                                    controller.serialNumber.text,
                                  );
                                },
                                content: Column(
                                  children: [
                                    AppTextField(
                                      type: 'serial num',
                                      iconData: Icons.numbers,
                                      inputType: TextInputType.number,
                                      onChanged: (p0) {},
                                      validator: (p0) {},
                                      textFieldController:
                                          controller.serialNumber,
                                      onSubmit: () async {},
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: const ListTile(
                              title:
                                  Center(child: Text('Reset Server')),
                            ),
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
