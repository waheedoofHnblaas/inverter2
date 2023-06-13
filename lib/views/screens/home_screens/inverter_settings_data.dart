import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverterCommands_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/core/class/handelingview.dart';
import 'package:invertar_us/data/model/inverterCommandsModel.dart';
import 'package:invertar_us/views/widgets/setting_widgets/choises_widget.dart';
import 'package:invertar_us/views/widgets/setting_widgets/setting_data_widgets.dart';
import 'package:invertar_us/views/widgets/setting_widgets/slider_widget.dart';

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
          color: Colors.blue.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: GetBuilder<InverterSettingsController>(
            builder: (inverterSettingsController) {
          return Center(
            child: HandelingRequest(
                statusRequest: inverterSettingsController.statusRequest,
                widget: Stack(
                  children: [
                    ListView.builder(
                      itemCount: inverterSettingsController
                          .editInverterSettingsMap.length,
                      itemBuilder: (context, index) {
                        String text = inverterSettingsController
                            .inverterSettingsMap.keys
                            .toList()[index];

                        String val = inverterSettingsController
                            .editInverterSettingsMap[index]
                            .toString();
                        CommandModel commandModel = CommandModel();
                        inverterSettingsController.showEdit = false;

                        for (CommandModel command
                            in inverterCommandsController.inverterCommandsList) {
                          print('objec=============================$index');
                          if (command.commandShortcutInSettings.toString() ==
                              text) {
                            commandModel = command;
                            inverterSettingsController.setEditShow(true);
                            break;
                          }
                        }

                        return settingDataCard(text, val,
                             index, commandModel);
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
                              print(key);
                              inverterSettingsController
                                      .inverterSettingsMap[key] =
                                  inverterSettingsController
                                      .editInverterSettingsMap[index];
                              index++;
                            });

                            print(inverterSettingsController.inverterSettingsMap);
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
