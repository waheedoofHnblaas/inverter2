import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller/login_contoller.dart';
import '../../../core/class/handelingview.dart';
import '../../../core/function/validinput.dart';
import '../../widgets/apploginbutton.dart';
import '../../widgets/apptextfield.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SafeArea(
        child: GetBuilder<LoginControllerImp>(builder: (controller) {
          return HandelingRequest(
            statusRequest: controller.statusRequest!,
            widget: Center(
              child: Form(
                key: controller.formState,
                child: ListView(children: [
                  Column(
                    children: [
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
                          controller.link = TextEditingController(text: val);

                          return validInput(val, 8, 50, 'password');
                        },
                      ),
                      // const SizedBox(
                      //   height:100,
                      // ),
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
                                  textFieldController: controller.serialNumber,
                                  onSubmit: () async {},
                                ),
                              ],
                            ),
                          );
                        },
                        child: const ListTile(
                          title: Center(child: Text('Reset Server')),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.keys.length,
                    itemBuilder: (context, index) {
                      return controller.keys.isNotEmpty
                          ? Container(
                              margin: const EdgeInsets.all(10),
                              decoration:
                                  BoxDecoration(border: Border.all(width: 0.3)),
                              child: InkWell(
                                onTap: () async {
                                  await controller.setAuthValues(
                                    controller.keys[index][0],
                                    controller.keys[index][1],
                                    controller.keys[index][2],
                                  );
                                },
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            controller.keys[index][3],
                                            style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 21,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Expanded(child: Container()),
                                          Text(
                                            controller.keys[index][1],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 8,
                                            ),
                                          ),
                                          Text(
                                            controller.keys[index][2],
                                            style: const TextStyle(
                                              color: Colors.grey,
                                              fontSize: 8,
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              await controller.removeAuthValue(
                                                controller.keys[index][3],
                                              );
                                            },
                                            icon: const Icon(
                                                Icons.delete_outline),
                                          )
                                        ],
                                      ),
                                      Text(
                                        controller.keys[index][0],
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 8,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          : const Center(child: CircularProgressIndicator());
                    },
                  ),
                ]),
              ),
            ),
          );
        }),
      ),
    );
  }
}
