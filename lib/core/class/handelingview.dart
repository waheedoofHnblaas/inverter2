import 'package:flutter/material.dart';
import 'package:invertar_us/core/class/statusrequest.dart';

import 'package:lottie/lottie.dart';

import '../constant/imagesassets.dart';
import 'package:get/get.dart';

class HandelingView extends StatelessWidget {
  HandelingView({Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  final StatusRequest statusRequest;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return Center(
          child: SizedBox(
              width: Get.width / 3,
              child: LinearProgressIndicator(
                color: Get.theme.primaryColor,
              )));
      // return Center(child: Lottie.asset(AppImagesAssets.loading));
    } else if (statusRequest == StatusRequest.success) {
      return widget;
    } else if (statusRequest == StatusRequest.failure) {
      return const Center(child: Text('no data'));
    } else {
      return Container();
    }
  }
}

class HandelingRequest extends StatelessWidget {
  HandelingRequest(
      {Key? key, required this.statusRequest, required this.widget})
      : super(key: key);

  final StatusRequest statusRequest;
  Widget widget;

  @override
  Widget build(BuildContext context) {
    if (statusRequest == StatusRequest.loading) {
      return Center(child: Lottie.asset(AppImagesAssets.loading));
    }
    // else if (statusRequest == StatusRequest.failure) {
    //   return const Text('no data');
    // }
    else if (statusRequest == StatusRequest.serverExp ||
        statusRequest == StatusRequest.offline) {
      return const Center(
        child: Text('Offline'),
      );
    } else {
      return widget;
    }
  }
}
