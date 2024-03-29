import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/user_setting_controller.dart';
import 'package:invertar_us/core/class/handelingview.dart';
import '../../../controllers/auth_controller/deleteUser_controller.dart';
import '../../../controllers/home_controllers/inverter_settings_controller.dart';
import '../../../controllers/home_controllers/system_user_controller.dart';
import '../../../core/class/statusrequest.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    DeleteUserController deleteUserController = Get.put(DeleteUserController());
    SystemUserControllerImp homeController = Get.find();
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  homeController.isAdmin ? 'Admin Panel' : 'Normal Panel',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Get.theme.primaryColor, fontSize: 21),
                ),
              ),
              const Divider(),
              homeController.isAdmin
                  ? Column(
                      children: [
                        InkWell(
                          onTap: () {
                            homeController.toRegisterPage();
                          },
                          child: const ListTile(
                            title: Text('Register new user'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            homeController.toChangePasswordPage();
                          },
                          child: const ListTile(
                            title: Text('Change Password'),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            homeController.toChangePasswordNormalPage();
                          },
                          child: const ListTile(
                            title: Text('Change Normal Password'),
                          ),
                        ),
                        GetBuilder<DeleteUserController>(
                            builder: (deleteController) {
                          return HandelingView(
                            statusRequest: deleteUserController.statusRequest!,
                            widget: InkWell(
                              onTap: () async {
                                await deleteUserController.deleteUser();
                              },
                              child: const ListTile(
                                title: Text('Delete Normal User'),
                              ),
                            ),
                          );
                        }),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text(
                            'Settings',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 21),
                          ),
                        ),
                        const Divider(),
                        GetBuilder<InverterSettingsController>(
                          builder: (controller) => HandelingView(
                            statusRequest: controller.statusRequest,
                            widget: InkWell(
                              onTap: () {
                                homeController.toInverterSettingsPage();
                              },
                              child: const ListTile(
                                title: Text('Edit Inverter Settings'),
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<UserSettingController>(
                          builder: (controller) => HandelingView(
                            statusRequest: controller.statusRequest,
                            widget: InkWell(
                              onTap: () async {
                                // homeController.toInverterSettingsPage();
                                await controller.toUserSettingPage();
                              },
                              child: const ListTile(
                                title: Text('Edit User Settings'),
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<UserSettingController>(
                          builder: (controller) => HandelingView(
                            statusRequest: controller.statusRequest,
                            widget: InkWell(
                              onTap: () async {
                                Get.defaultDialog(
                                  title: 'Confirm sensor calibration? ',
                                  content: const Text(''),
                                  onConfirm: () async {
                                    Get.back();
                                    await UserSettingController().clibLdr();
                                  },
                                );
                              },
                              child: const ListTile(
                                title: Text('Calibrate LDR sensor'),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ListTile(
                          title: Text(
                            'Troubleshoot',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                color: Get.theme.primaryColor, fontSize: 21),
                          ),
                        ),
                        const Divider(),
                        GetBuilder<SystemUserControllerImp>(
                            builder: (sysController) {
                          return HandelingView(
                            statusRequest: sysController.statusRequest,
                            widget: InkWell(
                              onTap: () async {
                                UserSettingController userSettings = Get.find();
                                await homeController.reset(
                                  userSettings
                                      .userSettingModel.inverterSerialNumber
                                      .toString(),
                                );
                              },
                              child: const ListTile(
                                title: Text('Reset Server'),
                              ),
                            ),
                          );
                        }),
                        GetBuilder<SystemUserControllerImp>(
                            builder: (sysController) {
                          return HandelingView(
                            statusRequest: sysController.statusRequest2,
                            widget: InkWell(
                              onTap: () async {
                                UserSettingController userSettings = Get.find();
                                await homeController.resetSettings(
                                  userSettings
                                      .userSettingModel.inverterSerialNumber
                                      .toString(),
                                );
                              },
                              child: const ListTile(
                                title: Text('Reset Inverter Settings'),
                              ),
                            ),
                          );
                        }),
                        InkWell(
                          onTap: () async {
                            await homeController.logout();
                          },
                          child: const ListTile(
                            title: Text('logout'),
                          ),
                        ),
                      ],
                    )
                  : InkWell(
                      onTap: () {
                        homeController.logout();
                      },
                      child: const ListTile(
                        title: Text('logout'),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
