import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverterCommands_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/core/class/handelingview.dart';
import 'package:invertar_us/data/model/inverterCommandsModel.dart';
import 'package:invertar_us/views/widgets/setting_widgets/setting_data_widgets.dart';

class InverterSettingPage extends StatelessWidget {
  const InverterSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InverterCommandsController inverterCommandsController = Get.find();
    InverterSettingsController inverterSettingsController = Get.find();
    inverterSettingsController.resetEditSettingsMap();
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Get.theme.scaffoldBackgroundColor.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(11)),
        ),
        child: GetBuilder<InverterSettingsController>(
            builder: (inverterSettingsController) {
          return Center(
            child: HandelingRequest(
                statusRequest: inverterSettingsController.statusRequest,
                widget: Stack(
                  children: [
                    // Text('=======inverterSettings======='),
                    // Text(inverterSettingsController.inverterSettingsMap.keys
                    //     .toList()
                    //     .toString()),
                    // Text('=======inverterCommandsList======='),
                    // Text(
                    //   inverterCommandsController
                    //       .inverterCommandsList[1].commandShortcutInSettings
                    //       .toString(),
                    // ),
                    ListView.builder(
                      itemCount: inverterSettingsController
                          .editInverterSettingsValuesList.length,
                      itemBuilder: (context, index) {
                        String text = inverterSettingsController
                            .inverterSettingsMap.keys
                            .toList()[index];

                        String val = inverterSettingsController
                            .editInverterSettingsValuesList[index]
                            .toString();
                        CommandModel commandModel = CommandModel();
                        // inverterSettingsController.showEdit = false;

                        bool show = false;
                        for (CommandModel command in inverterCommandsController
                            .inverterCommandsList) {
                          if (command.commandShortcutInSettings.toString() ==
                              text.toString()) {
                            commandModel = command;
                            show = true;
                            return settingDataCard(
                              text,
                              val,
                              index,
                              commandModel,
                              true,
                            );
                          }
                        }
                        return settingDataCard(
                          text,
                          val,
                          index,
                          commandModel,
                          false,
                        );
                      },
                    ),
                    Positioned(
                      bottom: 10,
                      left: Get.width / 1.4,
                      right: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.backgroundColor,
                          border: Border.all(color: Get.theme.primaryColor),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(33),
                          ),
                        ),
                        child: IconButton(
                          onPressed: () async {
                            int index = 0;
                            inverterSettingsController.inverterSettingsMap
                                .forEach((key, value) {
                              // print(key);
                              inverterSettingsController
                                      .inverterSettingsMap[key] =
                                  inverterSettingsController
                                      .editInverterSettingsValuesList[index];
                              index++;
                            });

                            print(
                                'editSettingsData=============================');
                            print(
                                inverterSettingsController.inverterSettingsMap);

                            print(
                                'editSettingsData=============================');
                            print(inverterCommandsController
                                .inverterCommandsList);
                            await inverterSettingsController.editSettingsData(
                              {
                                "Success": true,
                                "Inverter Settings": inverterSettingsController
                                    .inverterSettingsMap,
                              },
                            );
                          },
                          icon: const Icon(Icons.done),
                        ),
                      ),
                    )
                  ],
                )),
          );
        }),
      ),
    );
  }
}
