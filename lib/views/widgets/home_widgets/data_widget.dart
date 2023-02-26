import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controllers/inverter_data_controller.dart';
import '../../../controllers/home_controllers/user_setting_controller.dart';

class DataWidget extends StatelessWidget {
  const DataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    InverterDataController inverterDataController = Get.find();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: inverterDataController.dataList.length,
      itemBuilder: (context, index) {
        Map<String, dynamic> list =
        inverterDataController.dataList[index];
        return Container(
          decoration: BoxDecoration(
            borderRadius:
            const BorderRadius.all(Radius.circular(8)),
          ),
          padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.symmetric(vertical: 3),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: Get.width / 1.5,
                child: Text(
                  list.keys.toList()[0],
                  style: Get.textTheme.bodyText1,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                        Radius.circular(8))),
                width: Get.width / 6,
                child: Text(
                  list[list.keys.toList()[0]].toString(),
                  style: Get.textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}