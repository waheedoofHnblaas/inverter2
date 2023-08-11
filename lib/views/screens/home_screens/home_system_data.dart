import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverterCommands_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_data_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/controllers/home_controllers/system_user_controller.dart';
import 'package:invertar_us/controllers/home_controllers/user_setting_controller.dart';
import 'package:invertar_us/core/constant/imagesassets.dart';
import 'package:invertar_us/core/constant/messages.dart';
import 'package:invertar_us/views/widgets/home_widgets/important_data_widget.dart';
import '../../../core/class/handelingview.dart';
import '../../widgets/home_widgets/data_widget.dart';
import '../../widgets/home_widgets/drawer_widget.dart';
import '../../widgets/home_widgets/error_widget.dart';
import '../../widgets/home_widgets/title_widget.dart';

class HomeSystemDataPage extends StatelessWidget {
  const HomeSystemDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(UserSettingController());
    Get.put(SystemUserControllerImp(), permanent: false);
    Get.put(InverterSettingsController(), permanent: false);
    Get.put(InverterCommandsController());
    InverterDataController inverterDataController = Get.put(
      InverterDataController(),
    );

    getDataValue(int index) {
      return double.parse(double.parse(
        inverterDataController.dataList1[index].values.first.toString(),
      ).toStringAsFixed(1));
    }

    getDataKey(int i) {
      return inverterDataController.dataList1[i].keys.first.toString();
    }

    getFaultValue(int index) {
      return double.parse(
          inverterDataController.faultsList1[index].values.first.toString());
    }

    getFaultKey(int i) {
      return inverterDataController.faultsList1[i].keys.first.toString();
    }

    getMessages(int messageIndex) {
      inverterDataController.add(messageIndex);

      return SizedBox(
        width: Get.width / 1.16,
        child: Text(
          messageList[messageIndex],
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: Get.height / 55,
          ),
        ),
      );
    }

    removeMessages(int messageIndex) {
      inverterDataController.remove(messageIndex);
      return Container();
    }

    dataFaultsPage() {
      return Stack(
        children: [
          PageView(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Important Data',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ImportantDataWidget(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'DATA',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const DataWidget(),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Faults',
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const ErrorsWidget(),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Hero(
              tag: 'changeScroller',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  border: Border.all(
                    color: Get.theme.primaryColor,
                  ),
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor: Get.theme.scaffoldBackgroundColor,
                  child: IconButton(
                      onPressed: () {
                        inverterDataController.changeScroller(0);
                      },
                      icon: const Icon(Icons.keyboard_arrow_up)),
                ),
              ),
            ),
          )
        ],
      );
    }

    titleCard(text, icon) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: Get.width / 3.2,
            ),
            Row(
              children: [
                icon,
                const SizedBox(
                  width: 10,
                ),
                Text(
                  text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    cardWidget(text, value, icon) {
      return Expanded(
        child: Card(
          shape: OutlineInputBorder(
            borderSide: BorderSide(
              color: Get.theme.primaryColor,
              // width: 0.1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(18),
            ),
          ),
          child: SizedBox(
            height: Get.height/18,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  // const Icon(Icons.electric_bolt),
                  icon,
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    text,
                    style: const TextStyle(
                      fontWeight: FontWeight.w100,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(child: Container()),
                  Text(
                    value,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    onOffWidget(bool bool) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(13)),
          color: bool
              ? Colors.greenAccent
              : CupertinoColors.inactiveGray.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(bool ? 'ON' : 'OFF'),
        ),
      );
    }

    informationButtons() {
      SystemUserControllerImp homeController = Get.find();
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.power),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'AC',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: onOffWidget(getDataValue(2) > 80),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Card(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.sunny_snowing),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Solar',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: onOffWidget(getDataValue(28) > 30),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              !homeController.isAdmin
                  ? Container()
                  : cardWidget(
                      'Solar power',
                      getDataValue(28).toString(),
                      const Icon(Icons.solar_power),
                    ),
            ],
          ),
          Divider(color: Get.theme.primaryColor.withOpacity(0.5)),
          titleCard(
            'Battery',
            Image.asset(AppImagesAssets.battery, width: 35),
          ),
          Row(
            children: [
              !homeController.isAdmin
                  ? Container()
                  : cardWidget(
                      'Voltage',
                      getDataValue(10).toString(),
                      Image.asset(AppImagesAssets.voltmeter, width: 35),
                    ),
              cardWidget(
                'Percentage',
                getDataValue(12).toString(),
                Image.asset(AppImagesAssets.percent, width: 15),
              ),
            ],
          ),
          Divider(color: Get.theme.primaryColor.withOpacity(0.5)),
          titleCard(
            'Current load',
            Image.asset(AppImagesAssets.currentLoad, width: 35),
          ),
          !homeController.isAdmin
              ? Container()
              : Row(
                  children: [
                    cardWidget(
                      'Wattage',
                      getDataValue(6).toString(),
                      Image.asset(AppImagesAssets.watt, width: 35),
                    ),
                    cardWidget(
                      'Percentage',
                      getDataValue(8).toString(),
                      Image.asset(AppImagesAssets.percent, width: 15),
                    ),
                  ],
                ),
          Row(
            children: [
              cardWidget(
                'Ampere',
                (getDataValue(6) / getDataValue(4)).toStringAsFixed(1),
                Image.asset(AppImagesAssets.ammeter, width: 35),
              ),
            ],
          ),
          Divider(color: Get.theme.primaryColor.withOpacity(0.5)),
          titleCard(
            'Remaining load',
            Image.asset(AppImagesAssets.remainingLoad, width: 35),
          ),
          inverterDataController.errorLDRMessage == ''
              ? Container(
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.4),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Row(
                    children: [
                      !homeController.isAdmin
                          ? Container()
                          : cardWidget(
                              'Wattage',
                              (inverterDataController.projectedPower -
                                      getDataValue(6))
                                  .toStringAsFixed(1),
                              Image.asset(AppImagesAssets.watt, width: 35),
                            ),
                      cardWidget(
                        'Ampere',
                        ((inverterDataController.projectedPower -
                                    getDataValue(6)) /
                                getDataValue(4))
                            .toStringAsFixed(1),
                        Image.asset(AppImagesAssets.ammeter, width: 35),
                      )
                    ],
                  ),
                )
              : Container(
                  decoration: BoxDecoration(
                    color: Get.theme.primaryColor.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(18),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text(inverterDataController.errorLDRMessage),
                      ),
                      CircleAvatar(
                        radius: 8,
                        backgroundColor: inverterDataController.isReading
                            ? Colors.greenAccent
                            : CupertinoColors.inactiveGray.withOpacity(0.3),
                        child: Container(),
                      ),
                    ],
                  ),
                ),
          !homeController.isAdmin
              ? Container()
              : Row(
                  children: [
                    cardWidget(
                      'Output Voltage',
                      getDataValue(4).toString(),
                      Image.asset(AppImagesAssets.voltmeter, width: 35),
                    ),
                  ],
                ),
        ],
      );
    }

    actionsMessagesPage() {
      return Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                informationButtons(),
                const SizedBox(
                  height: 4,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(4.0),
                    child: Text(
                      'Actions',
                    ),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                inverterDataController.dataList1.isNotEmpty
                    ? Container(
                        decoration: BoxDecoration(
                          color: Get.theme.primaryColor.withOpacity(0.5),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Column(
                          children: [
                            (getDataValue(2) > 150)
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: (getDataValue(2) > 150)
                                        ? getMessages(10)
                                        : removeMessages(10),
                                  )
                                : Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: (getDataValue(10) > 27)
                                            ? getMessages(9)
                                            : removeMessages(9),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: (getDataValue(10) < 25 ||
                                                getDataValue(11) <= 5)
                                            ? getMessages(8)
                                            : removeMessages(8),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: (getFaultValue(15) == 1)
                                            ? getMessages(1)
                                            : removeMessages(1),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: (getFaultValue(13) == 1 ||
                                                getDataValue(10) < 22.5)
                                            ? getMessages(0)
                                            : removeMessages(0),
                                      ),
                                    ],
                                  ),
                            AnimatedContainer(
                              duration: const Duration(seconds: 1),
                              height: inverterDataController.condsList.any(
                                      (element) =>
                                          [2, 3, 4, 5, 6, 7].contains(element))
                                  ? null
                                  : 0,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: (getFaultValue(9) == 1)
                                        ? getMessages(7)
                                        : removeMessages(7),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        (getFaultValue(8) == 1)
                                            ? getMessages(6)
                                            : removeMessages(6),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: (getFaultValue(24) == 1)
                                        ? getMessages(5)
                                        : removeMessages(5),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: (getFaultValue(10) == 1 ||
                                            getFaultValue(11) == 1)
                                        ? getMessages(4)
                                        : removeMessages(4),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: (getFaultValue(16) == 1 ||
                                            getFaultValue(27) == 1 ||
                                            getFaultValue(28) == 1 ||
                                            getDataValue(8) >= 100)
                                        ? getMessages(3)
                                        : removeMessages(3),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    child: (getFaultValue(29) == 1)
                                        ? getMessages(2)
                                        : removeMessages(2),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    : const Center(
                        child: Text('No Connection'),
                      )
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            // left: Get.width,
            right: 10,
            child: Hero(
              tag: 'changeScroller',
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(25),
                  ),
                  border: Border.all(
                    color: Get.theme.primaryColor,
                  ),
                ),
                child: CircleAvatar(
                  radius: 25,
                  backgroundColor:
                      Get.theme.scaffoldBackgroundColor.withOpacity(0.8),
                  child: IconButton(
                    onPressed: () {
                      inverterDataController.changeScroller(
                          inverterDataController.currentPage + 1);
                    },
                    icon: Icon(
                      Icons.keyboard_arrow_down_outlined,
                      color: Get.theme.primaryColor,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    }

    return GetBuilder<SystemUserControllerImp>(
      builder: (controller) => Scaffold(
        drawer: Drawer(child: DrawerWidget()),
        appBar: AppBar(
          centerTitle: true,
          primary: true,
          title: const TitleWidget(),
          actions: [
            Obx(
              () => CircleAvatar(
                radius: 12,
                backgroundColor: inverterDataController.read.value
                    ? Colors.greenAccent
                    : Colors.grey.withOpacity(0.2),
                child: Container(),
              ),
            ),
            SizedBox(
              width: Get.width / 10,
            ),
            // IconButton(
            //   icon: const Icon(
            //     Icons.settings,
            //     size: 20,
            //   ),
            //   onPressed: () {
            //   },
            // ),
          ],
        ),
        body: GetBuilder<InverterDataController>(
          builder: (c) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: HandelingRequest(
                  statusRequest: inverterDataController.statusRequest,
                  widget:
                      // SingleChildScrollView(
                      //   child: Column(
                      //     children: [
                      //       Text(inverterDataController.dataList1.toString()),
                      //       Text('===========responce==============='),
                      //       Text(inverterDataController.ss.toString()),
                      //     ],
                      //   ),
                      // )
                      inverterDataController.dataList1.isNotEmpty
                          ? PageView(
                              controller: inverterDataController.pageController,
                              onPageChanged: (int page) {
                                inverterDataController.changeScroller(page);
                              },
                              scrollDirection: Axis.vertical,
                              children: [
                                actionsMessagesPage(),
                                dataFaultsPage(),
                              ],
                            )
                          : const Center(
                              child: Text('No Connection'),
                            ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
