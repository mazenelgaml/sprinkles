// ignore_for_file: file_names


import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/ui/privacypolicy/controller/privacy_policy_controller.dart';
import 'package:untitled/widgets/custom_text_widget.dart';
import 'package:untitled/widgets/loader.dart';

import '../../Utils/localization_services.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init:  PrivacyPolicyController(context),
      builder: (PrivacyPolicyController controller) =>
          Scaffold(
            appBar: AppBar(
                backgroundColor:kBackGroundColor,
                flexibleSpace: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [kDarkPinkColor,kLightPinkColor],
                      ),
                    )),

                centerTitle:true,
                title: Stack(
                  children: [
                    // Implement the stroke
                    CustomText(
                      drawerTag8.tr,
                      style: TextStyle(
                        fontSize: 15,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                        fontFamily: Get
                            .find<StorageService>()
                            .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth =3
                          ..color = kBackGroundColor,
                      ),
                    ),
                    // The text inside
                     CustomText(
                      drawerTag8.tr,
                      style:  TextStyle(
                        fontSize: 15,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w900,
                        fontFamily: Get
                            .find<StorageService>()
                            .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                        color: kDarkPinkColor,
                      ),
                    ),
                  ],
                ),
                leadingWidth:Get.width*0.25,
                leading:
                InkWell(
                  onTap:(){
                    Get.back();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(

                      decoration: BoxDecoration(
                        color:Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(
                              0.0,
                              0.0,
                            ),
                            blurRadius: 13.0,
                            spreadRadius: 2.0,
                          ), //BoxShadow
                          BoxShadow(
                            color: Colors.white.withOpacity(0.2),
                            offset: const Offset(0.0, 0.0),
                            blurRadius: 0.0,
                            spreadRadius: 0.0,
                          ), //BoxShadow
                        ],
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: Row(
                          mainAxisAlignment:MainAxisAlignment.center,
                          children:[
                            const Icon(
                                Icons.arrow_back_ios_rounded  ,color:kDarkPinkColor,size:15
                            ),
                            CustomText(
                              goBack.tr,
                              textAlign:TextAlign.left,
                              style: TextStyle(
                                height:1,
                                shadows: <Shadow>[
                                  Shadow(
                                      offset: const Offset(0.5, 0.5),
                                      blurRadius: 0.5,

                                      color: Colors.black.withOpacity(0.5)
                                  ),
                                ],
                                fontSize: 13,
                                letterSpacing: 0,
                                fontFamily: Get
                                    .find<StorageService>()
                                    .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                color: kDarkPinkColor,
                              ),
                            ),
                          ]

                      ),
                    ),
                  ),
                )

            ),
            body: controller.loading
                ? const Loader()
                : Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: ListView(
              children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: CustomText(Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.privacyData?.titleEn??"":controller.privacyData?.title??"",
                        style:  TextStyle(
                            fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                            color: kDarkPinkColor,
                            fontWeight: FontWeight.w800,
                            fontSize: 20),),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Html(
                      data: Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.privacyData?.descEn??"":controller.privacyData?.desc??"",
                      style: {
                        "body": Style(
                          fontFamily: Get.find<StorageService>().activeLocale == SupportedLocales.english?fontFamilyEnglishName:fontFamilyArabicName,
                          color: kDarkPinkColor,
                          fontWeight: FontWeight.w600,

                          fontSize: FontSize(20),
                        ),
                      },),
                  )
              ],
            ),
                ),
          ),
    );
  }
}
