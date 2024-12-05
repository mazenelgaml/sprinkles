
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/services/reporting_services.dart';
import 'package:untitled/widgets/alert_dialogue.dart';

class ReportController extends GetxController{

  final TextEditingController nameController =  TextEditingController();
  final TextEditingController msgController =  TextEditingController();

  bool isLoading = true;

  final FocusNode nameNode =  FocusNode();
  final FocusNode msgNode =  FocusNode();
  final String productId;
  final String storeId;
  ReportController(
      this.productId, this.storeId
      );
  final formKey = GlobalKey<FormState>();
  bool isOffline =false;
  unFocus() {
    nameNode.unfocus();
    msgNode.unfocus();
    update();
  }


  @override
  void onClose() {
    nameController.text="";
    msgController.text="";
    super.onClose();
  }
  sendMessage(context) async {
    if (!isOffline) {
      if (formKey.currentState!.validate()) {
        isLoading = true;
        update();

        var result = await ReportingServices().sendingReports(
          productId,
          storeId,
          nameController.text,
          msgController.text,

        );
        if (result?.status == "true") {
          isLoading = false;
          update();
          showDialog(context: context,
              builder: (context) {
                return AlertDialogue(alertTitle: successSendingReport.tr,
                    alertText: Get
                        .find<StorageService>()
                        .activeLocale == SupportedLocales.english ? result
                        ?.msg ?? "" : result?.msgAr ?? "",
                    alertIcon: "assets/icons/okIcon.png",
                    containerHeight: Get.height*0.4);
              }
          );
        } else {
          isLoading = false;
          update();
          showDialog(context: context,
              builder: (context) {
                return AlertDialogue(alertTitle: errorKey.tr,
                    alertText: Get
                        .find<StorageService>()
                        .activeLocale == SupportedLocales.english ? result
                        ?.msg ?? "" : result?.msgAr ?? "",
                    alertIcon: "assets/icons/warningIcon.png",
                    containerHeight: Get.height*0.4);
              }
          );
        }
      }
    }
  }
  String? massageValidator( String? value){

    if (value!.length < 2||value.isEmpty) {
      return "الرسالة مطلوبة";
    }
    return null;

  }
  String? nameValidator(String? value){
    if (value!.isEmpty||value.replaceAll(' ', '').isNumericOnly) {

      return "برجاء ادخال سبب الابلاغ";
    }
    return null;
  }


}