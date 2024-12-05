
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/models/privacy_policy_model.dart';
import 'package:untitled/services/app_info_services.dart';

class PrivacyPolicyController extends GetxController{
  late PrivacyPolicy? privacyData;
  bool loading = true;
  bool isOffline = false;
  final BuildContext context;
  @override
  PrivacyPolicyController(this.context);
  @override
  Future<void> onInit() async {

    super.onInit();
    getData();
  }

  getData() async {
    privacyData = await AppInfoServices().getPrivacyPolicy();
    loading = false;
    update();
  }
}