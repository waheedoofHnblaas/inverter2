import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:invertar_us/controllers/home_controllers/inverter_data_controller.dart';
import 'package:invertar_us/controllers/home_controllers/user_setting_controller.dart';
import '../../../controllers/home_controllers/system_user_controller.dart';
import '../../../core/class/handelingview.dart';
import '../../widgets/home_widgets/data_widget.dart';
import '../../widgets/home_widgets/drawer_widget.dart';
import '../../widgets/home_widgets/error_widget.dart';
import '../../widgets/home_widgets/title_widget.dart';

class HomeSystemDataPage extends StatelessWidget {
  HomeSystemDataPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InverterDataController inverterDataController = Get.put(
      InverterDataController(),
    );
    return Scaffold(
      drawer: Drawer(child: DrawerWidget()),
      appBar: AppBar(
        primary: true,
        title: const TitleWidget(),
        actions: [],
      ),
      body: GetBuilder<InverterDataController>(builder: (c) {
        return Center(
          child: HandelingView(
            statusRequest: inverterDataController.statusRequest,
            widget: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'DATA',
                  ),
                  const DataWidget(),
                  Divider(
                    color: Get.theme.primaryColor,
                  ),
                  const Text(
                    'Faults',
                  ),
                  const ErrorsWidget(),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
