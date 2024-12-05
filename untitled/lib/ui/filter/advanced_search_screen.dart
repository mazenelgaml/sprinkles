
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/ui/filter/controller/filter_controller.dart';
import 'package:untitled/ui/product_screen/widgets/product_loading_widget.dart';
import 'package:untitled/ui/store%20_screen/widget/store_loading_widget.dart';
import 'package:untitled/widgets/custom_text_widget.dart';

import '../../Utils/localization_services.dart';


class AdvancedSearchScreen extends StatelessWidget {


  const AdvancedSearchScreen({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return GetBuilder<FilterController>(
      init: FilterController(context),
      builder: (controller) => Scaffold(
        backgroundColor: kBackGroundColor,
        floatingActionButton: Visibility(
          visible: controller.isVisible,
          child: InkWell(
            onTap: (){
              controller. goUpToTopOfSScreen();
            },
            child: Container(
              width: Get.width*0.17,
              height: Get.height*0.08,
              decoration: BoxDecoration(
                border: Border.all( color:kBackGroundColor,width: 2),
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
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [kDarkPinkColor,kLightPinkColor],
                ),shape: BoxShape.circle,
              ),
              child:  Center(
                child: const Icon(
                  Icons.arrow_upward_sharp,
                  weight: 30,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        body: SingleChildScrollView(
          controller: controller.scrollController,
            child: Column(
              children: [
                Get.find<StorageService>().activeLocale == SupportedLocales.english?Stack(
                    children:[
                      Container(
                        height: Get.height*0.25,
                        width:Get.width,

                      ),
                      Positioned(
                        top:statusBarHeight-5,
                        right:0,
                        child: Stack(
                          children: [
                            Container(
                              height: Get.height*0.19,
                              width: Get.width*0.47,
                            ),
                            Positioned(
                              top:0,
                              child: SizedBox(
                                height: Get.height*0.19,
                                width: Get.width*0.47,
                                child: Image.asset("assets/images/cakeBG1.png",fit: BoxFit.fitHeight,),
                              ),
                            ),
                            Positioned(
                              top:5,
                              right:5,
                              child: Container(
                                width:Get.width*0.26,
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment:CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: Get.height*0.14,
                                      width: Get.width*0.26,
                                      child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitHeight,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top:statusBarHeight-5,
                        left:0,
                        child: Container(
                            height: Get.height*0.25,
                            width:Get.width*0.7,
                            child:     Padding(
                              padding: const EdgeInsets.fromLTRB(20.0,10,20.0,0),
                              child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,

                                  children:[
                                    InkWell(
                                      onTap:(){
                                        Get.back();
                                      },
                                      child: Container(
                                        child: const Row(
                                            children:[
                                              Icon(
                                                  Icons.arrow_back_ios_rounded  ,color:kDarkPinkColor,size:20
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width:10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(10.0,10,10.0,0),
                                      child: CustomText(
                                        greetingText.tr,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,

                                          fontSize: 25,
                                          letterSpacing: 0,
                                          fontFamily: fontFamilyArabicName,
                                          color: kDarkPinkColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(15.0,0,15.0,0),
                                      child: Center(
                                        child: CustomText(
                                          advancedSearchTitle.tr,
                                          style: const TextStyle(

                                            fontSize: 22,
                                            letterSpacing: 0,
                                            fontFamily: fontFamilyArabicName,
                                            color: kDarkPinkColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            )),),


                    ]
                ):
                Stack(
                    children:[
                      Container(
                        height: Get.height*0.25,
                        width:Get.width,

                      ),
                      Positioned(
                        top:statusBarHeight-5,
                        right:0,
                        child: Container(
                            height: Get.height*0.25,
                            width:Get.width*0.6,
                            child:     Padding(
                              padding: const EdgeInsets.fromLTRB(0,10,20.0,0),
                              child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,

                                  children:[
                                    InkWell(
                                      onTap:(){
                                        Get.back();
                                      },
                                      child: Container(
                                        child: const Row(
                                            children:[
                                              Icon(
                                                  Icons.arrow_back_ios_rounded  ,color:kDarkPinkColor,size:20
                                              ),
                                            ]
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width:10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,10.0,0),
                                      child: CustomText(
                                        greetingText.tr,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,

                                          fontSize: 25,
                                          letterSpacing: 0,
                                          fontFamily: fontFamilyArabicName,
                                          color: kDarkPinkColor,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(0,0,15.0,0),
                                      child: Center(
                                        child: CustomText(
                                          advancedSearchTitle.tr,
                                          style: const TextStyle(

                                            fontSize: 22,
                                            letterSpacing: 0,
                                            fontFamily: fontFamilyArabicName,
                                            color: kDarkPinkColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ]
                              ),
                            )),),
                      Positioned(
                        top:statusBarHeight-5,
                        left:0,
                        child: Stack(
                          children: [
                            Container(
                              height: Get.height*0.19,
                              width: Get.width*0.47,
                            ),
                            Positioned(
                              top:0,
                              child: SizedBox(
                                height: Get.height*0.19,
                                width: Get.width*0.47,
                                child: Image.asset("assets/images/cakeBG.png",fit: BoxFit.fitHeight,),
                              ),
                            ),
                            Positioned(
                              top:5,
                              left:5,
                              child: Container(
                                width:Get.width*0.26,
                                child: Row(
                                  mainAxisAlignment:MainAxisAlignment.start,
                                  crossAxisAlignment:CrossAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: Get.height*0.14,
                                      width: Get.width*0.26,
                                      child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitHeight,),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                    ]
                ),
                const SizedBox(height: 10,),
                controller.selectedTap == "s"?controller.isLoading?const StoreLoadingWidget():controller.shopList?.length == 0? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      children:[
                        SizedBox(
                          height: Get.height*0.4,
                          width: Get.width*0.6,
                          child: Image.asset("assets/images/we are open-cuate.png",fit: BoxFit.fitWidth,),
                        ),
                        const SizedBox(
                            height:50
                        ),
                        CustomText(
                          advancedSearchNoStoreData.tr,
                          textAlign:TextAlign.center,
                          style:  TextStyle(
                            fontSize:25,
                            fontFamily: Get
                                .find<StorageService>()
                                .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                            fontWeight: FontWeight.w900,

                            color: kDarkPinkColor,
                          ),
                        ),
                      ]
                  ),
                ):Column(
                  children:controller.storeListWidget,)
                    : controller.isLoading?const ProductLoadingWidget(isLoadingMoreData: false,):controller.pagenationData?.items?.length == 0? Column(
                    children:[
                      SizedBox(
                        height: Get.height*0.4,
                        width: Get.width*0.6,
                        child: Image.asset("assets/images/Product quality-bro.png",fit: BoxFit.fitWidth,),
                      ),
                      const SizedBox(
                          height:50
                      ),
                      CustomText(
                        advancedSearchNoProductData.tr,
                        textAlign:TextAlign.center,
                        style:  TextStyle(
                          fontSize:25,
                          fontFamily: Get
                              .find<StorageService>()
                              .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                          fontWeight: FontWeight.w600,
                          color: kDarkPinkColor,
                        ),
                      ),
                    ]
                ):Column(
                    children:
                    controller.products

                ),
                controller.isLoadingMoreData?ProductLoadingWidget(  isLoadingMoreData: controller.isLoadingMoreData,):SizedBox(),

              ],
            ),
          ),
        ),
    );

  }
}