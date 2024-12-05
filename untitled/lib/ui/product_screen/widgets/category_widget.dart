// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/models/category_model.dart';

import '../../../widgets/custom_text_widget.dart';

class CategoryWidget extends StatelessWidget {
  const CategoryWidget({Key? key, this.category, required this.selectedCategoryId}) : super(key: key);
  final CategoryModel? category;
  final int selectedCategoryId;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Container(
        height: Get.height*0.13,


        child:Column(
          crossAxisAlignment:CrossAxisAlignment.center,
          mainAxisAlignment:MainAxisAlignment.start,
          children: [

            Center(
              child: Stack(
                  children:[
                    SizedBox(
                      height: Get.height*0.09,
                      width:Get.width*0.17,

                    ),
                    Positioned(
                      top:0,
                      child: Container(
                        height: Get.height*0.08,
                        width:Get.width*0.17,
                        decoration: BoxDecoration(
                          color:selectedCategoryId == category?.id?kDarkPinkColor:kLightPinkColor,
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Positioned(
                      top:0,
                      left: 5,
                      child: CachedNetworkImage(
                        fit:  BoxFit.contain,
                        imageUrl: "${Services.baseEndPoint}${category?.img??""}",
                        imageBuilder: ((context, image){
                          return   Container(
                              height: Get.height*0.075,

                              width:Get.width*0.14,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: image,
                                  fit:  BoxFit.fitHeight,
                                ),
                              ));
                        }),
                        placeholder: (context, image){
                          return   Container(

                            height: Get.height*0.075,

                            width:Get.width*0.14,
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

                                height: Get.height*0.07,

                                width:Get.width*0.13,
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
                            height: Get.height*0.075,

                            width:Get.width*0.14,
                            child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitHeight,),
                          );
                        },
                      ),
                    ),
                  ]
              ),
            ),
             Center(
              child: CustomText(
            Get.find<StorageService>().activeLocale == SupportedLocales.english?category?.nameEn??"":category?.name??"",
                style:  TextStyle(

                  fontSize: 12,
                  letterSpacing: 0,
                  fontFamily: Get
                      .find<StorageService>()
                      .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                  fontWeight: selectedCategoryId == category?.id?FontWeight.w900:FontWeight.w600,
                  color:Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
