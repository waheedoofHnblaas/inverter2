import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/data/model/inverterCommandsModel.dart';


chiosesWidget(int index, CommandModel commandModel) {
  return GetBuilder<InverterSettingsController>(
    builder: (inverterSettingsController) {
      return SingleChildScrollView(
        child: Column(
          children: List.generate(
            commandModel
                .boundries!.choices!.length,
                (i) {
              List choises = commandModel
                  .boundries!.choices!.keys
                  .toList();
              return InkWell(
                onTap: () {
                  inverterSettingsController
                      .editInverterSettingsValuesList[
                  index] = choises[i].toString();
                  inverterSettingsController
                      .update();
                },
                child: Container(
                  color: inverterSettingsController
                      .editInverterSettingsValuesList[
                  index] ==
                      choises[i]
                      ? Colors.greenAccent
                      : null,
                  child: Padding(
                    padding:
                    const EdgeInsets.all(
                        8.0),
                    child: Text(
                      choises[i],
                      style: const TextStyle(
                          color: Colors.red),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
    },
  );
}
