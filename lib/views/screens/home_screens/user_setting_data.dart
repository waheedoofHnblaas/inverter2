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

    cardWidget(int index, List<String> keys, List<dynamic> values) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              color: Get.theme.primaryColor.withOpacity(0.4),
            ),
            color: Get.theme.scaffoldBackgroundColor.withOpacity(0.7),
            borderRadius: const BorderRadius.all(Radius.circular(18)),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 3.0,
              horizontal: 2,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: Get.width / 2.6,
                  child: Column(
                    children: [
                      Text(
                        keys[index][0].toUpperCase() +
                            keys[index]
                                .replaceAll('_', ' ')
                                .replaceRange(0, 1, ''),
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: Container()),
                SizedBox(
                  width: Get.width / 2,
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          index == 2
                              ? Text('5<')
                              : index == 3
                              ? Text('3<')
                              : index == 5
                              ? Text('0<')
                              : index == 6
                              ? Text('0<')
                              : Container(),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
                            child: Row(
                              children: [
                                Text(
                                  values[index].toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(index == 1 ? ' volt' : '')
                              ],
                            ),
                          ),
                          index == 2
                              ? Text('<300')
                              : index == 3
                              ? Text('<300')
                              : index == 5
                              ? Text('<100')
                              : index == 6
                              ? Text('<5000')
                              : Container(),
                        ],
                      ),
                      TextEditWidget(index: index),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Settings'),
        actions: [

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Get.theme.primaryColor,
        child: Icon(
          Icons.done,
          color: Get.theme.scaffoldBackgroundColor,
        ),
        onPressed: () async {
          if (int.parse(userSettingController.readTimeText.text.toString()) >
                  300 ||
              int.parse(userSettingController.readTimeText.text.toString()) <
                  5) {
            Get.snackbar('values error', 'read time must be between 5 and 300');
          } else if (int.parse(userSettingController.avgText.text.toString()) >
                  300 ||
              int.parse(userSettingController.avgText.text.toString()) < 3) {
            Get.snackbar(
                'values error', 'last reading avg must be between 3 and 300');
          } else if (int.parse(
                      userSettingController.solarPanels.text.toString()) >
                  100 ||
              int.parse(userSettingController.solarPanels.text.toString()) <
                  0) {
            Get.snackbar(
                'values error', 'solar panels must be between 0 and 100');
          } else if (int.parse(userSettingController.singleSolarMaxPower.text
                      .toString()) >
                  5000 ||
              int.parse(userSettingController.singleSolarMaxPower.text
                      .toString()) <
                  0) {
            Get.snackbar('values error',
                'single Solar Max Power must be between 0 and 5000');
          } else {
            await userSettingController.setUserSettingData(
              userSettingController.readTimeText.text,
              userSettingController.homeNameText.text,
              userSettingController.avgText.text,
              userSettingController.solarPanels.text,
              userSettingController.singleSolarMaxPower.text,
            );
            await userSettingController.getUserReadTimeData();
          }
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
                    (index) => cardWidget(index, keys, values),
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
            type: 'Seconds',
            iconData: Icons.data_array,
            inputType: keys[index] != 'home_name'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: (p0) {
              print(userSettingController.readTimeText.text);
              userSettingController.readTimeText =
                  TextEditingController(text: p0);
            },
            validator: (p0) {
              // return validInput(p0!, 1, 100, 'password');
            },
            textFieldController: userSettingController.readTimeText,
            onSubmit: () async {},
          ),
        );
      case 3:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: 'Minutes',
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
            type: 'Panels',
            iconData: Icons.data_array,
            inputType: keys[index] != 'home_name'
                ? TextInputType.number
                : TextInputType.text,
            onChanged: null,
            validator: (p0) {
              print(userSettingController.solarPanels.text);
              userSettingController.solarPanels =
                  TextEditingController(text: p0);
              return validInput(p0!, 1, 100, 'password');
            },
            textFieldController: userSettingController.solarPanels,
            onSubmit: () async {},
          ),
        );
      case 6:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: 'Watts',
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
      case 7:
        return SizedBox(
          width: Get.width / 2.2,
          child: AppTextField(
            type: '',
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
      default:
        return Container();
    }
  }
}
