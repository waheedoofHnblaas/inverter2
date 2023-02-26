import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/views/widgets/setting_widgets/choises_widget.dart';
import 'package:invertar_us/views/widgets/setting_widgets/slider_widget.dart';
Widget settingDataCard(text,val,inverterSettingsController,index,commandModel) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      SizedBox(
        width: Get.width / 1.8,
        child: Text(
          text,
        ),
      ),
      SizedBox(
        width: Get.width / 3.1,
        child: Text(
          val,
        ),
      ),
      inverterSettingsController.showEdit
          ? IconButton(
        onPressed: () {
          if (val == 'enabled') {
            inverterSettingsController
                .editInverterSettingsMap[index] = 'disabled';
            inverterSettingsController.update();
          } else if (val == 'disabled') {
            inverterSettingsController
                .editInverterSettingsMap[index] = 'enabled';
            inverterSettingsController.update();
          } else {
            Get.defaultDialog(
              title: text,
              content: commandModel.boundries!.min != null
                  ? sliderWidget(index, commandModel)
                  : chiosesWidget(index, commandModel),
            );
          }
        },
        icon: Icon(
          Icons.edit,
          color: Get.theme.primaryColor,
        ),
      )
          : IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.edit,
          color: Get.theme.scaffoldBackgroundColor,
        ),
      )
    ],
  );
}