import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/data/model/inverterCommandsModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
sliderWidget(
    int index,
    CommandModel commandModel,
    ) {
  double min = double.parse(
    commandModel.boundries!.min.toString(),
  );
  double max = double.parse(
    commandModel.boundries!.max.toString(),
  );
  int div = ((max - min) ~/ double.parse(commandModel.increamental!));

  return GetBuilder<InverterSettingsController>(
      builder: (inverterSettingsController) {
        return Column(
          children: [
            Text(
              inverterSettingsController.editInverterSettingsValuesList[index].toString(),
            ),
            Slider.adaptive(
              divisions: div,
              value: double.parse(
                inverterSettingsController.editInverterSettingsValuesList[index]
                    .toString(),
              ),
              min: min,
              max: max,
              label: inverterSettingsController.editInverterSettingsValuesList[index]
                  .toString(),
              onChanged: (valNew) {
                inverterSettingsController.editInverterSettingsValuesList[index] = valNew;
                print(valNew);
                inverterSettingsController.update();
              },
            ),
          ],
        );
      });
}