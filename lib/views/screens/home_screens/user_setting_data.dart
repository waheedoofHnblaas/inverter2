import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/core/class/handelingview.dart';
import 'package:invertar_us/core/function/validinput.dart';
import 'package:invertar_us/views/widgets/apptextfield.dart';
import '../../../controllers/home_controllers/user_setting_controller.dart';

class UserSettingPage extends StatelessWidget {
  const UserSettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserSettingController userSettingController = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(
          Icons.done,
          color: Get.theme.scaffoldBackgroundColor,
        ),
        onPressed: () async {
          await userSettingController.setUserSettingData(
            userSettingController.readTimeText.text,
            userSettingController.homeNameText.text,
            userSettingController.avgText.text,
            userSettingController.solarPanels.text,
            userSettingController.singleSolarMaxPower.text,
          );
          await userSettingController.getUserReadTimeData();
        },
      ),
      body: GetBuilder<UserSettingController>(
        builder: (controller) {
          var values =
              userSettingController.userSettingModel.toJson().values.toList();
          var keys =
              userSettingController.userSettingModel.toJson().keys.toList();
          return HandelingRequest(
            statusRequest: userSettingController.statusRequest,
            widget: Center(
              child: SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    keys.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColorLight,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(11)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 3.0,
                            horizontal: 2,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Get.width / 2.2,
                                child: Column(
                                  children: [
                                    Text(
                                      keys[index],
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      values[index].toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              TextEditWidget(index: index)
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TextEditWidget extends StatelessWidget {
  TextEditWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  int index;

  @override
  Widget build(BuildContext context) {
    UserSettingController userSettingController = Get.find();
    var values =
        userSettingController.userSettingModel.toJson().values.toList();
    var keys = userSettingController.userSettingModel.toJson().keys.toList();

    switch (index) {
      case 2:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: keys[index].toString(),
            iconData: Icons.data_array,
            inputType: keys[index] != 'home_name'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: null,
            validator: (p0) {
              print(userSettingController.readTimeText.text);
              userSettingController.readTimeText =
                  TextEditingController(text: p0);
              return validInput(p0!, 1, 100, 'password');
            },
            textFieldController: userSettingController.readTimeText,
            onSubmit: () async {},
          ),
        );
      case 3:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: keys[index].toString(),
            iconData: Icons.data_array,
            inputType: keys[index] != 'home_name'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: null,
            validator: (p0) {
              print(userSettingController.avgText.text);
              userSettingController.avgText = TextEditingController(text: p0);
              return validInput(p0!, 1, 100, 'password');
            },
            textFieldController: userSettingController.avgText,
            onSubmit: () async {},
          ),
        );
      case 5:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: keys[index].toString(),
            iconData: Icons.data_array,
            inputType: keys[index] != 'home_name'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: null,
            validator: (p0) {
              print(userSettingController.solarPanels.text);
              userSettingController.solarPanels = TextEditingController(text: p0);
              return validInput(p0!, 1, 100, 'password');
            },
            textFieldController: userSettingController.solarPanels,
            onSubmit: () async {},
          ),
        );
      case 7:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: keys[index].toString(),
            iconData: Icons.data_array,
            inputType: keys[index] != 'home_name'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: null,
            validator: (p0) {
              print(userSettingController.homeNameText.text);
              userSettingController.homeNameText =
                  TextEditingController(text: p0);
              return validInput(p0!, 1, 100, 'password');
            },
            textFieldController: userSettingController.homeNameText,
            onSubmit: () async {},
          ),
        );
      case 6:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: keys[index].toString(),
            iconData: Icons.data_array,
            inputType: keys[index] != 'home_name'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: null,
            validator: (p0) {
              print(userSettingController.singleSolarMaxPower.text);
              userSettingController.singleSolarMaxPower =
                  TextEditingController(text: p0);
              return validInput(p0!, 1, 100, 'password');
            },
            textFieldController: userSettingController.singleSolarMaxPower,
            onSubmit: () async {},
          ),
        );
      default:
        return IconButton(
          onPressed: () {},
          icon: Row(
            children: [
              Icon(
                Icons.edit,
                color: Get.theme.primaryColorLight,
                size: 16,
              )
            ],
          ),
        );
    }
  }
}
