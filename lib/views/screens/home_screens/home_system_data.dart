import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverterCommands_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_data_controller.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_settings_controller.dart';
import 'package:invertar_us/controllers/home_controllers/system_user_controller.dart';
import 'package:invertar_us/controllers/home_controllers/user_setting_controller.dart';
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
      return double.parse(
          inverterDataController.dataList1[index].values.first.toString());
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
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 10,
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
            left: Get.width / 2.4,
            child: Hero(
              tag: 'changeScroller',
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Get.theme.primaryColor,
                child: IconButton(
                    onPressed: () {
                      inverterDataController.changeScroller(0);
                    },
                    icon: const Icon(Icons.keyboard_arrow_up)),
              ),
            ),
          )
        ],
      );
    }

    informationButtons() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
                        Switch(
                          activeColor: Colors.greenAccent,
                          value: getDataValue(2) < 80,
                          onChanged: (value) {},
                        )
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
                        Switch(
                          activeColor: Colors.greenAccent,
                          value: getDataValue(28) > 30,
                          onChanged: (value) {},
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.solar_power),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Solar power',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          getDataValue(28).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 0.8, thickness: 1),
          const Text('Battery', style: TextStyle(fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.electric_bolt),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'voltage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          getDataValue(10).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.countertops_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'percentage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          getDataValue(12).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 0.8, thickness: 1),
          const Text('Current load',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.center_focus_strong_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'wattage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          getDataValue(6).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.countertops_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'percentage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          getDataValue(8).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.countertops_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'amper',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          (getDataValue(6) / getDataValue(4))
                              .toStringAsFixed(3),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 0.8, thickness: 1),
          const Text('Remaining load',
              style: TextStyle(fontWeight: FontWeight.bold)),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.center_focus_strong_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'wattage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          (inverterDataController.projectedPower -
                                  getDataValue(6))
                              .toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  shape: OutlineInputBorder(
                    borderSide: BorderSide(color: Get.theme.primaryColor),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.countertops_outlined),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'amper',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          ((inverterDataController.projectedPower -
                                      getDataValue(6)) /
                                  getDataValue(4))
                              .toStringAsFixed(2),
                          style: const TextStyle(fontWeight: FontWeight.bold),
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
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(Icons.electric_bolt),
                        const SizedBox(
                          width: 4,
                        ),
                        const Text(
                          'Output voltage',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Expanded(child: Container()),
                        Text(
                          getDataValue(4).toString(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
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
            left: Get.width / 2.4,
            child: Hero(
              tag: 'changeScroller',
              child: CircleAvatar(
                radius: 25,
                backgroundColor: Get.theme.primaryColor,
                child: IconButton(
                    onPressed: () {
                      inverterDataController.changeScroller(
                          inverterDataController.currentPage + 1);
                    },
                    icon: const Icon(Icons.keyboard_arrow_down_outlined)),
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
          primary: true,
          title: const TitleWidget(),
          actions: [
            Obx(
              () => CircleAvatar(
                radius: 10,
                backgroundColor: inverterDataController.read.value
                    ? Colors.greenAccent
                    : Colors.transparent,
                child: Container(),
              ),
            ),
            const SizedBox(
              width: 30,
            ),
          ],
        ),
        body: GetBuilder<InverterDataController>(
          builder: (c) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Center(
                child: HandelingRequest(
                  statusRequest: inverterDataController.statusRequest,
                  widget: inverterDataController.dataList1.isNotEmpty
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
                      : const Center(child: Text('No Connection')),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
