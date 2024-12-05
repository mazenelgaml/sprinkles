import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/ui/product_detailed_screen/photo_details_screen.dart';
import 'package:untitled/widgets/custom_text_widget.dart';

class ProductImageWidget extends StatelessWidget {
  const ProductImageWidget({Key? key, required this.imageUrl, required this.activeIndex, required this.imageTotalCount, this.imagesLink}) : super(key: key);
  final String? imageUrl;
  final int activeIndex;
  final String imageTotalCount;
  final List<String>? imagesLink;
  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap:(){
        Get.to(()=> PhotoDetailedScreen(link: imagesLink,index:activeIndex));
      },
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        imageUrl:  "${Services.baseEndPoint}${imageUrl??""}",
        imageBuilder: ((context, image){
          return  Stack(
            children: [
              Hero(
                tag:"imageHero$activeIndex",
                child: Container(
                    width:Get.width,
                    height:Get.height*0.5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: image,
                        fit:  BoxFit.fill,
                      ),
                    )
                ),
              ),
              Positioned(
                left:10,
                top:10,
                child: Container(
                    width:Get.width*0.15,
                    height:Get.height*0.03,
                  decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(20),
                    color:kBackGroundColor.withOpacity(0.65),
                  ),
                  child:Center(
                    child: CustomText(
                      "${activeIndex+1}/$imageTotalCount",
                      style:  TextStyle(
                        height: 1.3,
                        fontSize: 12,
                        letterSpacing: 0,
                        fontFamily: Get
                            .find<StorageService>()
                            .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                        color: kDarkPinkColor,
                      ),
                    ),

                  )
                    ),
              )

            ],
          );
        }),
        placeholder: (context, image){
          return   Container(

            width:Get.width,
            height:Get.height*0.4,
            decoration:BoxDecoration(
              color:  const Color(0xFFF2F0F3),
              borderRadius: BorderRadius.circular(15),
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

                width:Get.width*0.95,
                height:Get.height*0.38,
                decoration:BoxDecoration(
                  color:  const Color(0xFFDFDDDF),
                  borderRadius: BorderRadius.circular(15),

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
            width:Get.width,
            height:Get.height*0.4,
            child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitHeight,),
          );
        },
      ),
    );
  }
}
