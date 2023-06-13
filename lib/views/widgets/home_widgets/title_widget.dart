import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/core/class/handelingview.dart';
import 'package:invertar_us/core/class/statusrequest.dart';

import '../../../controllers/home_controllers/user_setting_controller.dart';

class TitleWidget extends StatelessWidget {
  const TitleWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserSettingController>(builder: (userSettingController) {
      return HandelingView(
        statusRequest: userSettingController.statusRequest,
        widget: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '${userSettingController.userSettingModel.homeName} : '
              '${userSettingController.userSettingModel.inverterSerialNumber}',
            ),
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                userSettingController.toUserSettingPage();
              },
            )
          ],
        ),
      );
    });
  }

}
