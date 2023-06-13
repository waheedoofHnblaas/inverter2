import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../controllers/home_controllers/inverter_data_controller.dart';
import '../../../controllers/home_controllers/user_setting_controller.dart';

class ImportantDataWidget extends StatelessWidget {
  const ImportantDataWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // InverterDataController inverterDataController = Get.find();

    return Card(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.5),
          borderRadius: const BorderRadius.all(Radius.circular(20)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
              height: Get.height / 1.3,
              child: GetBuilder<InverterDataController>(
                builder: (inverterDataController) => inverterDataController
                        .dataList1.isNotEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(inverterDataController
                                  .dataList1[10].keys.first),
                              Text(
                                inverterDataController
                                    .dataList1[10].values.first
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(inverterDataController
                                  .dataList1[2].keys.first),
                              Text(
                                inverterDataController.dataList1[2].values.first
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(inverterDataController
                                  .dataList1[15].keys.first),
                              Text(
                                inverterDataController
                                    .dataList1[15].values.first
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(inverterDataController
                                  .dataList1[8].keys.first),
                              Text(
                                inverterDataController.dataList1[8].values.first
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(inverterDataController
                                  .dataList1[4].keys.first),
                              Text(
                                inverterDataController.dataList1[4].values.first
                                    .toString(),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(inverterDataController
                                  .faultsList1[2].keys.first),
                              Text(
                                inverterDataController
                                    .faultsList1[2].values.first
                                    .toString(),
                              ),
                            ],
                          ),
                        ],
                      )
                    : const Center(
                        child: Text('NO Connection'),
                      ),
              )),
        ),
      ),
    );
  }
}
