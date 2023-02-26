import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/auth_controller/deleteUser_controller.dart';
import '../../../controllers/home_controllers/system_user_controller.dart';
import '../../../core/class/statusrequest.dart';
import '../apploginbutton.dart';

class DrawerWidget extends StatelessWidget {
  DrawerWidget();

  // SystemControllerImp controller;

  SystemUserControllerImp homeController = Get.find();
  @override
  Widget build(BuildContext context) {
    DeleteUserController deleteUserController = Get.put(DeleteUserController());
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  homeController.username,
                  style: Get.textTheme.bodyText1,
                ),
                homeController.isAdmin == true
                    ? Text(
                        '  is Admin',
                        style: Get.textTheme.bodyText2,
                      )
                    : Text(
                        '  is Normal User',
                        style: Get.textTheme.bodyText2,
                      ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                onPressed: () {
                  homeController.toInverterSettingsPage();
                },
                icon: const Icon(Icons.settings, size: 40),
              ),
            ),
            SizedBox(
              width: Get.width / 1.4,
              child: Text(
                'User Authentication',
                textAlign: TextAlign.start,
                style: TextStyle(color: Get.theme.primaryColor),
              ),
            ),
            homeController.isAdmin
                ? Column(
                    children: [
                      AppSignUpAndLoginButton(
                        text: 'Register new user',
                        onPressed: () {
                          homeController.toRegisterPage();
                        },
                      ),
                      AppSignUpAndLoginButton(
                        text: 'Change Password',
                        onPressed: () {
                          homeController.toChangePasswordPage();
                        },
                      ),
                      AppSignUpAndLoginButton(
                        text: 'Change Password of Normal User',
                        onPressed: () {
                          homeController.toChangePasswordNormalPage();
                        },
                      ),
                      GetBuilder<DeleteUserController>(
                          builder: (deleteController) {
                        if (deleteController.statusRequest ==
                            StatusRequest.success) {
                          return AppSignUpAndLoginButton(
                            text: 'Delete Normal User',
                            onPressed: () async {
                              await deleteUserController.deleteUser();
                            },
                          );
                        } else {
                          return const CircularProgressIndicator();
                        }
                      }),
                      AppSignUpAndLoginButton(
                        text: 'logout',
                        onPressed: () {
                          homeController.logout();
                        },
                      ),
                    ],
                  )
                : AppSignUpAndLoginButton(
              text: 'logout',
              onPressed: () {
                homeController.logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
