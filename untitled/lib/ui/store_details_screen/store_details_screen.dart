// ignore_for_file: avoid_print, sized_box_for_whitespace, unnecessary_string_interpolations, unnecessary_brace_in_string_interps, avoid_unnecessary_containers, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/ui/contact_us/report_screen.dart';
import 'package:untitled/ui/product_screen/widgets/category_loading_widget.dart';
import 'package:untitled/ui/product_screen/widgets/category_widget.dart';
import 'package:untitled/ui/product_screen/widgets/product_loading_widget.dart';
import 'package:untitled/ui/store_details_screen/controller/store_detailed_screen.dart';
import 'package:untitled/ui/store_details_screen/widget/commet_screen.dart';
import 'package:untitled/ui/store_details_screen/widget/read_more_widget.dart';
import 'package:untitled/widgets/DrawerWidget.dart';
import 'package:untitled/widgets/custom_text_widget.dart';

import '../../Utils/constant.dart';


class StoreDetailedScreen extends StatefulWidget {
  const StoreDetailedScreen({Key? key, required this.shopId, required this.mainCategoryId, required this.mainCategoryImg,}) : super(key: key);

  final String shopId;

  final String mainCategoryImg;

  final int mainCategoryId;

  @override
  State<StoreDetailedScreen> createState() => _StoreDetailedScreenState();
}

class _StoreDetailedScreenState extends State<StoreDetailedScreen> {


  @override
  void initState() {
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).viewPadding.top;
    return GetBuilder(
      init:  StoreDetailedController( context:context, mainCategoryId:widget.mainCategoryId, shopId: widget.shopId, mainCategoryImg: widget.mainCategoryImg,  ),
      builder: (StoreDetailedController controller) =>  Scaffold(
        key: controller.scaffoldState,
        drawer: AppDrawers(scaffoldKey: controller.scaffoldState,),
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
        body:  SingleChildScrollView(
          controller: controller.scrollController,
          child: Container(
            decoration:  const BoxDecoration(
                color: kBackGroundColor
            ),
            child:   Center(
              child: Column(
                children: [

                  Get.find<StorageService>().activeLocale == SupportedLocales.english?Stack(

                      children:[
                        Container(
                          height: Get.height*0.31,
                          width:Get.width,
                          child:const Padding(padding: EdgeInsets.all(0),
                          ),
                        ),
                        Positioned(

                          top:statusBarHeight-5,
                          right:0,
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height*0.235,
                                width: Get.width*0.6,
                              ),
                              Positioned(
                                  top:0,
                                  child: SizedBox(
                                    height: Get.height*0.235,
                                    width: Get.width*0.6,
                                    child: Image.asset("assets/images/cakeBG1.png",fit: BoxFit.fitWidth,),
                                  )),
                              Positioned(
                                top:15,
                                right:10,
                                child: Container(
                                  width:Get.width*0.48,
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.end,
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [


                                      controller.shopIsLoading?Container(

                                        height: Get.height*0.11,
                                        width: Get.width*0.23,
                                        decoration:BoxDecoration(

                                          color:  const Color(0xFFF2F0F3),
                                          shape: BoxShape.circle,
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
                                        ),
                                        child:Center(
                                          child: Container(

                                            height: Get.height*0.09,
                                            width: Get.width*0.2,
                                            decoration:const BoxDecoration(
                                              color:  Color(0xFFDFDDDF),
                                              shape: BoxShape.circle,

                                            ),
                                          ).animate(onPlay: (controller) => controller.repeat())
                                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                              .animate() // this wraps the previous Animate in another Animate
                                          ,
                                        ),
                                      ).animate(onPlay: (controller) => controller.repeat())
                                          .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                          .animate() // this wraps the previous Animate in another Animate
                                          :CachedNetworkImage(
                                        fit:  BoxFit.fitWidth,
                                        imageUrl: "${Services.baseEndPoint}${controller.selectedCategoryImage}",
                                        imageBuilder: ((context, image){
                                          return   Container(
                                              height: Get.height*0.14,
                                              width: Get.width*0.25,
                                              decoration: BoxDecoration(

                                                image: DecorationImage(
                                                  image: image,
                                                  fit:  BoxFit.fitWidth,
                                                ),
                                              ));
                                        }),
                                        placeholder: (context, image){
                                          return   Container(
                                            height: Get.height*0.11,
                                            width: Get.width*0.23,
                                            decoration:BoxDecoration(
                                              color:  const Color(0xFFF2F0F3),
                                              borderRadius: BorderRadius.circular(50),
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
                                            ),
                                            child:Center(
                                              child: Container(

                                                height: Get.height*0.09,
                                                width: Get.width*0.2,
                                                decoration:BoxDecoration(
                                                  color:  const Color(0xFFDFDDDF),
                                                  borderRadius: BorderRadius.circular(50),

                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                              ,
                                            ),
                                          ).animate(onPlay: (controller) => controller.repeat())
                                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                              .animate() // this wraps the previous Animate in another Animate
                                              ;
                                        },
                                        errorWidget: (context, url, error){
                                          return SizedBox(
                                            height: Get.height*0.14,
                                            width: Get.width*0.25,
                                            child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.contain,),
                                          );
                                        },
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

                            width:Get.width*0.6,
                            child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:[
                                  Container(
                                    width:Get.width*0.4,
                                    child:  Padding(
                                      padding:  const EdgeInsets.fromLTRB(8,8,8,2),
                                      child:Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                  onTap:(){
                                                    Get.back();
                                                  },
                                                  child: const Icon( Icons.arrow_back_ios_rounded  ,color:kDarkPinkColor,size:25)),
                                              InkWell(
                                                  onTap:(){
                                                    controller.scaffoldState.currentState!.openDrawer();
                                                  },
                                                  child: const Icon( Icons.subject_rounded ,color:kDarkPinkColor,size:30)),

                                            ],
                                          ),
                                          InkWell(
                                            onTap: (){
                                              final Locale newLocale =
                                              Get.find<StorageService>().activeLocale == SupportedLocales.arabic
                                                  ? SupportedLocales.english
                                                  : SupportedLocales.arabic;
                                              //in storage
                                              Get.find<StorageService>().activeLocale = newLocale;
                                              //in Getx
                                              Get.updateLocale(newLocale);
                                            },
                                            child: CustomText(
                                              translateButton.tr,
                                              style: TextStyle(
                                                fontSize:15,
                                                fontFamily: Get
                                                    .find<StorageService>()
                                                    .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                                fontWeight: FontWeight.w600,
                                                color: kDarkPinkColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 18.0),
                                    child: Container(
                                      width:Get.width*0.4,
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [

                                          controller.shopIsLoading?Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                                            child: Container(
                                              height: Get.height*0.08,
                                              width:Get.width*0.19,
                                              decoration:BoxDecoration(
                                                color:  const Color(0xFFF2F0F3),
                                                shape: BoxShape.circle,
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
                                              ),
                                              child:Center(
                                                child: Container(

                                                  height: Get.height*0.07,
                                                  width:Get.width*0.15,
                                                  decoration:BoxDecoration(
                                                    color:  const Color(0xFFDFDDDF),
                                                    shape: BoxShape.circle,

                                                  ),
                                                ).animate(onPlay: (controller) => controller.repeat())
                                                    .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                    .animate() // this wraps the previous Animate in another Animate
                                                ,
                                              ),
                                            ).animate(onPlay: (controller) => controller.repeat())
                                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                .animate(),
                                          )  // this wraps the previous Animate in another Animate
                                              : CachedNetworkImage(
                                            fit:  BoxFit.contain,
                                            imageUrl:  "${Services.baseEndPoint}${controller.shopData?.image??""}",
                                            imageBuilder: ((context, image){
                                              return   Container(
                                                  height: Get.height*0.11,
                                                  width:Get.width*0.2,
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: Colors.white,
                                                    image: DecorationImage(
                                                      image: image,
                                                      fit:  BoxFit.contain,
                                                    ),
                                                  ));
                                            }),
                                            placeholder: (context, image){
                                              return   Padding(
                                                padding: const EdgeInsets.symmetric(vertical: 7.0),

                                                child: Container(

                                                  height: Get.height*0.08,
                                                  width:Get.width*0.17,
                                                  decoration:BoxDecoration(
                                                    color:  const Color(0xFFF2F0F3),
                                                    shape: BoxShape.circle,
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
                                                  ),
                                                  child:Center(
                                                    child: Container(
                                                      height: Get.height*0.07,
                                                      width:Get.width*0.15,
                                                      decoration:const BoxDecoration(
                                                        color:  Color(0xFFDFDDDF),
                                                        shape: BoxShape.circle,

                                                      ),
                                                    ).animate(onPlay: (controller) => controller.repeat())
                                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                        .animate() // this wraps the previous Animate in another Animate
                                                    ,
                                                  ),
                                                ).animate(onPlay: (controller) => controller.repeat())
                                                    .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                    .animate(),
                                              ) // this wraps the previous Animate in another Animate
                                                  ;
                                            },
                                            errorWidget: (context, url, error){
                                              return SizedBox(
                                                height: Get.height*0.1,
                                                width:Get.width*0.2,
                                                child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitHeight,),
                                              );
                                            },
                                          ),
                                          Column(
                                            children: [
                                              controller.shopIsLoading?Center(
                                                child:   Container(
                                                  width: Get.width*0.06,
                                                  height: 20,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFFDFDDDF),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ).animate(onPlay: (controller) => controller.repeat())
                                                    .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                    .animate() // this wraps the previous Animate in another Animate
                                                    .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                    .slide(),


                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide():Container(

                                                child: Padding(
                                                  padding: const EdgeInsets.all(5.0),
                                                  child: InkWell(
                                                    onTap:(){
                                                      controller.addingOrRemovingStoreToFavorite(context);
                                                    },
                                                    child: Container(
                                                        height: Get.height*0.045,
                                                        width:Get.width*0.089,
                                                        decoration: const BoxDecoration(
                                                          color:kLightPinkColor,
                                                          shape: BoxShape.circle,
                                                        ),
                                                        child: Center(
                                                          child:controller.storeAreAddedOrNot?const Icon(
                                                              Icons.favorite,
                                                              color: Colors.white,
                                                              size:20
                                                          ):const Icon(
                                                              Icons.favorite_border_rounded,
                                                              color: Colors.white,
                                                              size:20
                                                          ),
                                                        )
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(height: 10,),
                                              controller.shopIsLoading?Center(
                                                child:   Container(
                                                  width: Get.width*0.06,
                                                  height: 20,
                                                  decoration: const BoxDecoration(
                                                    color: Color(0xFFDFDDDF),
                                                    shape: BoxShape.circle,
                                                  ),
                                                ).animate(onPlay: (controller) => controller.repeat())
                                                    .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                    .animate() // this wraps the previous Animate in another Animate
                                                    .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                    .slide(),


                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide():InkWell(
                                                onTap:(){
                                                  Share.share(controller.shopData?.link??"");
                                                },
                                                child: Container(
                                                    height: Get.height*0.04,
                                                    width:Get.width*0.08,
                                                    decoration: const BoxDecoration(
                                                      color:Colors.white,
                                                      shape: BoxShape.circle,
                                                    ),
                                                    child:  Center(
                                                      child: SizedBox(
                                                        height: Get.height*0.02,
                                                        width: Get.width*0.09,
                                                        child: Image.asset("assets/icons/s.png",fit: BoxFit.fitHeight,),
                                                      ),
                                                    )
                                                ),
                                              ),
                                            ],)

                                        ],
                                      ),
                                    ),
                                  ),

                                  controller.shopIsLoading?
                                  Center(
                                    child:   Container(
                                      width:Get.width*0.35,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFDFDDDF),
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                    ).animate(onPlay: (controller) => controller.repeat())
                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                        .animate() // this wraps the previous Animate in another Animate
                                        .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                        .slide(),


                                  ).animate(onPlay: (controller) => controller.repeat())
                                      .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                      .animate() // this wraps the previous Animate in another Animate
                                      .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                      .slide()
                                      :Container(
                                    width:Get.width*0.6,
                                    child:  Padding(
                                      padding:const EdgeInsets.only(left: 18.0),
                                      child: CustomText(
                                        Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.shopData?.nameEn??"":controller.shopData?.name??"",
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          shadows: <Shadow>[
                                            Shadow(
                                                offset: const Offset(0.5, 0.5),
                                                blurRadius: 0.5,

                                                color: Colors.black.withOpacity(0.5)
                                            ),
                                          ],
                                          fontWeight: FontWeight.w800,
                                          fontSize: 15,
                                          letterSpacing: 0,
                                          fontFamily: Get
                                              .find<StorageService>()
                                              .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kDarkPinkColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding:  EdgeInsets.fromLTRB(18.0,3,0,0),
                                    child: InkWell(
                                      onTap:(){

                                      },
                                      child: Container(

                                        width:Get.width*0.55,
                                        decoration: BoxDecoration(

                                          borderRadius: BorderRadius.circular(15), //
                                        ),
                                        child:  controller.shopIsLoading?Center(
                                          child:   Column(
                                            children: [
                                              Container(
                                                width:Get.width*0.4,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                              Container(
                                                width:Get.width*0.45,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                              Container(
                                                width:Get.width*0.45,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                              Container(
                                                width:Get.width*0.45,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                            ],
                                          ).animate(onPlay: (controller) => controller.repeat())
                                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                              .animate() // this wraps the previous Animate in another Animate
                                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                              .slide(),


                                        ):
                                        Center(
                                          child: Center(
                                            child:  ReadMoreText(Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.shopData?.descEn??"":controller.shopData?.desc??"",
                                              textAlign: TextAlign.left,
                                              trimLines: 3,
                                              trimLength: 90,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 12,
                                                letterSpacing: 0,
                                                fontFamily: Get
                                                    .find<StorageService>()
                                                    .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                                color:Colors.black,
                                              ),colorClickableText: kLightPinkColor,  semanticsLabel: '',),

                                          ),
                                        ),
                                      ),
                                    ),
                                  ),


                                ]
                            ),
                          ),
                        ),



                      ]
                  )
                      :Stack(
                      children:[
                        Container(
                          height: Get.height*0.31,
                          width:Get.width,
                          child:const Padding(padding: EdgeInsets.all(0),
                          ),
                        ),
                        Positioned(
                          top:statusBarHeight-5,
                          right:0,
                          child: Container(

                            width:Get.width*0.6,
                            child: Column(
                                crossAxisAlignment:CrossAxisAlignment.start,
                                children:[
                                  Container(
                                    width:Get.width*0.4,
                                    child:  Padding(
                                      padding:  const EdgeInsets.fromLTRB(8,8,8,2),
                                      child:Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              InkWell(
                                                onTap:(){
                                                  Get.back();
                                                },
                                                child: const Icon( Icons.arrow_back_ios_rounded  ,color:kDarkPinkColor,size:25)),
                                              InkWell(
                                                  onTap:(){
                                                    controller.scaffoldState.currentState!.openDrawer();
                                                  },
                                                  child: const Icon( Icons.subject_rounded ,color:kDarkPinkColor,size:30)),

                                            ],
                                          ),
                                          InkWell(
                                            onTap: (){
                                              final Locale newLocale =
                                              Get.find<StorageService>().activeLocale == SupportedLocales.arabic
                                                  ? SupportedLocales.english
                                                  : SupportedLocales.arabic;
                                              //in storage
                                              Get.find<StorageService>().activeLocale = newLocale;
                                              //in Getx
                                              Get.updateLocale(newLocale);
                                            },
                                            child: CustomText(
                                              translateButton.tr,
                                              style: TextStyle(
                                                fontSize:15,
                                                fontFamily: Get
                                                    .find<StorageService>()
                                                    .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                                fontWeight: FontWeight.w600,
                                                color: kDarkPinkColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(right: 18.0),
                                    child: Container(
                                      width:Get.width*0.4,
                                      child: Row(
                                        mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:CrossAxisAlignment.start,
                                        children: [

                                          controller.shopIsLoading?Padding(
                                            padding: const EdgeInsets.symmetric(vertical: 15.0),
                                            child: Container(
                                              height: Get.height*0.08,
                                              width:Get.width*0.19,
                                              decoration:BoxDecoration(
                                                color:  const Color(0xFFF2F0F3),
                                                shape: BoxShape.circle,
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
                                              ),
                                              child:Center(
                                                child: Container(

                                                  height: Get.height*0.07,
                                                  width:Get.width*0.15,
                                                  decoration:BoxDecoration(
                                                    color:  const Color(0xFFDFDDDF),
                                                    shape: BoxShape.circle,

                                                  ),
                                                ).animate(onPlay: (controller) => controller.repeat())
                                                    .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                    .animate() // this wraps the previous Animate in another Animate
                                                ,
                                              ),
                                            ).animate(onPlay: (controller) => controller.repeat())
                                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                .animate(),
                                          )  // this wraps the previous Animate in another Animate
                                              : CachedNetworkImage(
                                                fit:  BoxFit.contain,
                                                imageUrl:  "${Services.baseEndPoint}${controller.shopData?.image??""}",
                                                imageBuilder: ((context, image){
                                                  return   Container(
                                                      height: Get.height*0.11,
                                                      width:Get.width*0.2,
                                                      decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white,
                                                        image: DecorationImage(
                                                          image: image,
                                                          fit:  BoxFit.contain,
                                                        ),
                                                      ));
                                                }),
                                                placeholder: (context, image){
                                                  return   Padding(
                                                    padding: const EdgeInsets.symmetric(vertical: 7.0),

                                                    child: Container(

                                                      height: Get.height*0.08,
                                                      width:Get.width*0.17,
                                                      decoration:BoxDecoration(
                                                        color:  const Color(0xFFF2F0F3),
                                                        shape: BoxShape.circle,
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
                                                      ),
                                                      child:Center(
                                                        child: Container(
                                                          height: Get.height*0.07,
                                                          width:Get.width*0.15,
                                                          decoration:const BoxDecoration(
                                                            color:  Color(0xFFDFDDDF),
                                                            shape: BoxShape.circle,

                                                          ),
                                                        ).animate(onPlay: (controller) => controller.repeat())
                                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                            .animate() // this wraps the previous Animate in another Animate
                                                        ,
                                                      ),
                                                    ).animate(onPlay: (controller) => controller.repeat())
                                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                        .animate(),
                                                  ) // this wraps the previous Animate in another Animate
                                                      ;
                                                },
                                                errorWidget: (context, url, error){
                                                  return SizedBox(
                                                    height: Get.height*0.1,
                                                    width:Get.width*0.2,
                                                    child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitHeight,),
                                                  );
                                                },
                                              ),
                                          Column(
                                            children: [
                                            controller.shopIsLoading?Center(
                                              child:   Container(
                                                width: Get.width*0.06,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFDFDDDF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),


                                            ).animate(onPlay: (controller) => controller.repeat())
                                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                .animate() // this wraps the previous Animate in another Animate
                                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                .slide():Container(

                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: InkWell(
                                                  onTap:(){
                                                    controller.addingOrRemovingStoreToFavorite(context);
                                                  },
                                                  child: Container(
                                                      height: Get.height*0.045,
                                                      width:Get.width*0.089,
                                                      decoration: const BoxDecoration(
                                                        color:kLightPinkColor,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      child: Center(
                                                        child:controller.storeAreAddedOrNot?const Icon(
                                                            Icons.favorite,
                                                            color: Colors.white,
                                                            size:20
                                                        ):const Icon(
                                                            Icons.favorite_border_rounded,
                                                            color: Colors.white,
                                                            size:20
                                                        ),
                                                      )
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: 10,),
                                            controller.shopIsLoading?Center(
                                              child:   Container(
                                                width: Get.width*0.06,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                  color: Color(0xFFDFDDDF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),


                                            ).animate(onPlay: (controller) => controller.repeat())
                                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                .animate() // this wraps the previous Animate in another Animate
                                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                .slide():InkWell(
                                              onTap:(){
                                                Share.share(controller.shopData?.link??"");
                                              },
                                              child: Container(
                                                  height: Get.height*0.04,
                                                  width:Get.width*0.08,
                                                  decoration: const BoxDecoration(
                                                    color:Colors.white,
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child:  Center(
                                                    child: SizedBox(
                                                      height: Get.height*0.02,
                                                      width: Get.width*0.09,
                                                      child: Image.asset("assets/icons/s.png",fit: BoxFit.fitHeight,),
                                                    ),
                                                  )
                                              ),
                                            ),
                                          ],)


                                        ],
                                      ),
                                    ),
                                  ),

                            controller.shopIsLoading?
                            Center(
                              child:   Container(
                                width:Get.width*0.35,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: const Color(0xFFDFDDDF),
                                    borderRadius: BorderRadius.circular(50)
                                ),
                              ).animate(onPlay: (controller) => controller.repeat())
                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                  .animate() // this wraps the previous Animate in another Animate
                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                  .slide(),


                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                .slide()
                                :Container(
                              width:Get.width*0.6,
                                child:  Padding(
                                  padding: EdgeInsets.only(right:18),
                                  child: CustomText(
                                    Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.shopData?.nameEn??"":controller.shopData?.name??"",
                                    textAlign: TextAlign.right,
                                    style: TextStyle(
                                      shadows: <Shadow>[
                                        Shadow(
                                            offset: const Offset(0.5, 0.5),
                                            blurRadius: 0.5,

                                            color: Colors.black.withOpacity(0.5)
                                        ),
                                      ],
                                      fontSize: 15,
                                      letterSpacing: 0,
                                      fontFamily: Get
                                          .find<StorageService>()
                                          .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kDarkPinkColor,
                                    ),
                                  ),
                                ),
                            ),
                                  Padding(
                                    padding:  EdgeInsets.fromLTRB(0,3,18,0),
                                    child: InkWell(
                                      onTap:(){

                                      },
                                      child: Container(

                                        width:Get.width*0.55,
                                        decoration: BoxDecoration(

                                          borderRadius: BorderRadius.circular(15), //
                                        ),
                                        child:  controller.shopIsLoading?Center(
                                          child:   Column(
                                            children: [
                                              Container(
                                                width:Get.width*0.4,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                              Container(
                                                width:Get.width*0.45,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                              Container(
                                                width:Get.width*0.45,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                              Container(
                                                width:Get.width*0.45,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(),
                                            ],
                                          ).animate(onPlay: (controller) => controller.repeat())
                                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                              .animate() // this wraps the previous Animate in another Animate
                                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                              .slide(),


                                        ): ReadMoreText(Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.shopData?.descEn??"":controller.shopData?.desc??"",
                                          textAlign: TextAlign.start,
                                          trimLines: 3,
                                          trimLength: 90,
                                          style: TextStyle(
                                           fontWeight: FontWeight.w600,
                                            fontSize: 12,
                                            letterSpacing: 0,
                                            fontFamily: Get
                                                .find<StorageService>()
                                                .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                            color:Colors.black,
                                          ),colorClickableText: kLightPinkColor,  semanticsLabel: '',),
                                      ),
                                    ),
                                  ),


                                ]
                            ),
                          ),
                        ),
                        Positioned(

                              top:statusBarHeight-5,
                              left:0,
                          child: Stack(
                            children: [
                              Container(
                                height: Get.height*0.235,
                                width: Get.width*0.6,
                              ),
                              Positioned(
                                  top:0,
                                  child: SizedBox(
                                    height: Get.height*0.235,
                                    width: Get.width*0.6,
                                    child: Image.asset("assets/images/cakeBG.png",fit: BoxFit.fitWidth,),
                                  )),
                             Positioned(
                               top:15,
                                left:10,
                                child: Container(
                                  width:Get.width*0.48,
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.end,
                                    crossAxisAlignment:CrossAxisAlignment.start,
                                    children: [


                                      controller.shopIsLoading?Container(
                                        height: Get.height*0.11,
                                        width: Get.width*0.23,
                                        decoration:BoxDecoration(
                                          color:  const Color(0xFFF2F0F3),
                                          borderRadius: BorderRadius.circular(50),
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
                                        ),
                                        child:Center(
                                          child: Container(

                                            height: Get.height*0.09,
                                            width: Get.width*0.2,
                                            decoration:BoxDecoration(
                                              color:  const Color(0xFFDFDDDF),
                                              borderRadius: BorderRadius.circular(50),

                                            ),
                                          ).animate(onPlay: (controller) => controller.repeat())
                                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                              .animate() // this wraps the previous Animate in another Animate
                                          ,
                                        ),
                                      ).animate(onPlay: (controller) => controller.repeat())
                                          .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                          .animate() // this wraps the previous Animate in another Animate
                                          :CachedNetworkImage(
                                        fit:  BoxFit.fitWidth,
                                        imageUrl: "${Services.baseEndPoint}${controller.selectedCategoryImage}",
                                        imageBuilder: ((context, image){
                                          return   Container(
                                              height: Get.height*0.14,
                                              width: Get.width*0.25,
                                              decoration: BoxDecoration(

                                                image: DecorationImage(
                                                  image: image,
                                                  fit:  BoxFit.fitWidth,
                                                ),
                                              ));
                                        }),
                                        placeholder: (context, image){
                                          return   Container(
                                            height: Get.height*0.11,
                                            width: Get.width*0.23,
                                            decoration:BoxDecoration(
                                              color:  const Color(0xFFF2F0F3),
                                              borderRadius: BorderRadius.circular(50),
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
                                            ),
                                            child:Center(
                                              child: Container(

                                                height: Get.height*0.09,
                                                width: Get.width*0.2,
                                                decoration:BoxDecoration(
                                                  color:  const Color(0xFFDFDDDF),
                                                  borderRadius: BorderRadius.circular(50),

                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                              ,
                                            ),
                                          ).animate(onPlay: (controller) => controller.repeat())
                                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                              .animate() // this wraps the previous Animate in another Animate
                                              ;
                                        },
                                        errorWidget: (context, url, error){
                                          return SizedBox(
                                            height: Get.height*0.14,
                                            width: Get.width*0.25,
                                            child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.contain,),
                                          );
                                        },
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

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [

                          controller.shopIsLoading?Center(
                            child:   Container(
                              width: Get.width*0.06,
                              height: 20,
                              decoration: const BoxDecoration(
                                  color: Color(0xFFDFDDDF),
                                 shape: BoxShape.circle,
                              ),
                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                .slide(),


                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                              .slide():Container(

                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap:() async {
                                  await controller.makePhoneCall();
                                },
                                child:  SizedBox(
                                  height: Get.height*0.045,
                                  width:Get.width*0.089,
                                  child: Image.asset("assets/icons/c.png",fit: BoxFit.fitWidth,),
                                ),
                              ),
                            ),
                          ),
                          controller.shopIsLoading?Center(
                            child:   Container(
                              width: Get.width*0.06,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDFDDDF),
                                shape: BoxShape.circle,
                              ),
                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                .slide(),


                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                              .slide():Container(

                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap:(){
                                  controller.whatsapp();
                                },
                                child: SizedBox(
                                  height: Get.height*0.045,
                                  width:Get.width*0.089,
                                  child: Image.asset("assets/icons/w.png",fit: BoxFit.fitWidth,),
                                ),
                              ),
                            ),
                          ),


                          controller.shopIsLoading?Center(
                            child:   Container(
                              width: Get.width*0.06,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDFDDDF),
                                shape: BoxShape.circle,
                              ),
                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                .slide(),


                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                              .slide():Container(

                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap:(){
                                  Get.to(() =>CommentsScreen(comments:controller.comments,));
                                },
                                child: Container(
                                    height: Get.height*0.045,
                                    width:Get.width*0.089,
                                    decoration: const BoxDecoration(
                                      color:kDarkPinkColor,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Center(
                                      child:Icon(
                                          Icons.comment,
                                          color: Colors.white,
                                          size:20
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ),
                          controller.shopIsLoading?Center(
                            child:   Container(
                              width: Get.width*0.06,
                              height: 20,
                              decoration: const BoxDecoration(
                                color: Color(0xFFDFDDDF),
                                shape: BoxShape.circle,
                              ),
                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                .slide(),


                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                              .slide():Container(

                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap:(){
                                  controller.showStoreLocation();
                                },
                                child:  const Icon(Icons.pin_drop_outlined,color:  kDarkPinkColor,size:30)
                              ),
                            ),
                          ),

                          controller.shopIsLoading?
                          Center(
                            child:   Container(
                              width:Get.width*0.35,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFDFDDDF),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                .slide(),


                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                              .slide()
                              :RatingBar.builder(
                            initialRating:double.parse("${controller.shopData?.star??0}") ,
                            minRating: 1,
                            itemSize:15,
                            direction: Axis.horizontal,
                            ignoreGestures:true,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                            itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              print(rating);
                            },
                          ),
                          controller.shopIsLoading?Center(
                            child:   Container(
                              width: Get.width*0.06,
                              height: 20,
                              decoration: BoxDecoration(
                                  color: const Color(0xFFDFDDDF),
                                  borderRadius: BorderRadius.circular(50)
                              ),
                            ).animate(onPlay: (controller) => controller.repeat())
                                .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                .animate() // this wraps the previous Animate in another Animate
                                .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                .slide(),


                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                              .slide(): Row(
                              children:[
                                CustomText(
                                  "${controller.shopData?.visitors??0}",
                                  textAlign:TextAlign.left,
                                  style: TextStyle(
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
                                const Icon(
                                    Icons.remove_red_eye_outlined  ,color:kDarkPinkColor,size:20
                                ),

                              ]

                          )
                        ],
                      ),

                 controller.shopIsLoading?const CategoryLoadingWidget():controller.shopData?.ctgs?.length == 0||controller.shopData?.ctgs?.length == 1||controller.shopData?.ctgs?.length == 2? const SizedBox():Container(
                   width:Get.width*0.95,
                   height: Get.height*0.13,
                    child: ListView.builder(
                      scrollDirection:Axis.horizontal,

                      shrinkWrap:true,
                      itemCount:controller.shopData?.ctgs?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return
                          InkWell(
                              onTap:(){
                                controller.selectingAnotherSubCategory(controller.shopData!.ctgs![index]);
                              },
                              child: CategoryWidget(category:controller.shopData?.ctgs![index], selectedCategoryId:  controller.selectedSubCategoryId,)); },

                    ),
                  ),


                  controller.shopProductIsLoading?const ProductLoadingWidget(isLoadingMoreData: false,):
                  controller.productList?.length == 0?Column(
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
                          controller.shopData?.ctgs?.length == 0?storeDetailedError2.tr:storeDetailedError1.tr
                           ,
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
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0,10,0,10),
                    child: InkWell(
                      onTap:(){
                        Get.to(()=>ReportScreen(productId: '0', storeId:"${controller.shopData?.id??0}" ,),transition:Transition.upToDown);
                      },
                      child: Container(
                        width: Get.width,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                              children:[
                                const Icon(
                                    Icons.report_gmailerrorred  ,color:kDarkPinkColor,size:30
                                ),
                                CustomText(
                                  reportTitle.tr,
                                  textAlign:TextAlign.left,
                                  style: TextStyle(

                                    fontSize: 18,
                                    letterSpacing: 0,
                                    fontFamily: Get
                                        .find<StorageService>()
                                        .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                    color: kDarkPinkColor,
                                    fontWeight: FontWeight.w900
                                  ),
                                ),


                              ]

                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
