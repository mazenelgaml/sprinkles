import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/models/user_data_model.dart';
import 'package:untitled/services/auth_services.dart';
import 'package:untitled/services/biomatrics_auth_services.dart';
import 'package:untitled/ui/edit_password/edit_password_screen.dart';

class ProfileController extends GetxController{
  late UserDataModel? userData;
  bool isLoading = true;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Future<void> onInit() async {
    super.onInit();
    getProfileData();

  }
  getProfileData() async {
    userData = await AuthServices.getUserData( Get.find<StorageService>().getId);
    isLoading = false;
    update();
  }

  goToChangePass() async {
    if(await BiomatricsAuthService.authenticateUser("تغير كلمه السر")) {
      Get.to(()=>const EditPasswordScreen());
    }
  }
}