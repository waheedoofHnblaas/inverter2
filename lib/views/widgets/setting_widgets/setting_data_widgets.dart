import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/data/model/inverterCommandsModel.dart';
import 'package:invertar_us/views/widgets/setting_widgets/choises_widget.dart';
import 'package:invertar_us/views/widgets/setting_widgets/slider_widget.dart';

class SettingsCardWidget extends StatelessWidget {
  SettingsCardWidget(
      this.text, this.val, this.commandModel, this.show, this.index,
      {super.key});

  String text;
  String val;
  int index;
  CommandModel commandModel;
  bool show;

  @override
  Widget build(BuildContext context) {
    Widget settingDataCard(
      text,
      val,
      index,
      commandModel,
      show,
    ) {
      return Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: Get.width / 1.8,
              child: Text(
                text.toString()[0].toUpperCase() +
                    text.toString().replaceAll('_', ' ').replaceRange(0, 1, ''),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(11)),
              ),
              width: Get.width / 4.5,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Text(
                  val,
                ),
              ),
            ),
            GetBuilder<InverterSettingsController>(
                builder: (inverterSettingsController) {
              return show
                  ? IconButton(
                      onPressed: () {
                        if (val == 'enabled') {
                          inverterSettingsController
                                  .editInverterSettingsValuesList[index] =
                              'disabled';
                          inverterSettingsController.update();
                        } else if (val == 'disabled') {
                          inverterSettingsController
                                  .editInverterSettingsValuesList[index] =
                              'enabled';
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
                      onPressed: () {
                        print('not active');
                      },
                      icon: Icon(
                        Icons.edit,
                        color: Colors.blueAccent.withOpacity(0.1),
                      ),
                    );
            }),
          ],
        ),
      );
    }

    return GetBuilder<InverterSettingsController>(
      builder: (controller) {
        return settingDataCard(text, val, index, commandModel, show);
      }
    );
  }
}
