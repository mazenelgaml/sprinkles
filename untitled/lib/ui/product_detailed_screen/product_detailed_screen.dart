// ignore_for_file: avoid_unnecessary_containers, sized_box_for_whitespace, avoid_print, unnecessary_string_interpolations, prefer_is_empty

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/ui/contact_us/report_screen.dart';
import 'package:untitled/ui/favorite_screen/controller/favorite_controller.dart';
import 'package:untitled/ui/ordering/ordering_screen.dart';
import 'package:untitled/ui/product_detailed_screen/controller/product_detailed_controller.dart';
import 'package:untitled/ui/product_detailed_screen/photo_details_screen.dart';
import 'package:untitled/ui/product_detailed_screen/widget/comment_loading_widget.dart';
import 'package:untitled/ui/product_detailed_screen/widget/comment_widget.dart';
import 'package:untitled/ui/product_detailed_screen/widget/product_image_widget.dart';
import 'package:untitled/ui/product_detailed_screen/widget/read_more_widget.dart';
import 'package:untitled/ui/product_detailed_screen/widget/seller_product_loading_widget.dart';
import 'package:untitled/ui/product_detailed_screen/widget/video_player_widget.dart';
import 'package:untitled/ui/product_screen/controller/product_contoller.dart';
import 'package:untitled/ui/product_screen/widgets/product_widget.dart';
import 'package:untitled/ui/store_details_screen/store_details_screen.dart';
import 'package:untitled/ui/store_details_screen/widget/commet_screen.dart';
import 'package:untitled/widgets/custom_text_widget.dart';

class ProductDetailedScreen extends StatelessWidget {
  const ProductDetailedScreen({Key? key, required this.productId, required this.mainCategoryId, required this.comingFromProductList, required this.comingFromFavoriteList, required this.comingFromProductDetails, required this.branchCategoryId, required this.mainCategoryImg}) : super(key: key);
  final String mainCategoryImg;
  final String? productId;
  final int mainCategoryId;
  final bool comingFromProductList;
  final bool comingFromFavoriteList;
  final bool comingFromProductDetails;
  final int branchCategoryId;

  @override
  Widget build(BuildContext context) {
    final gController = Get.put(ProductController(mainCategoryId,context,false,mainCategoryImg));
    final fController = Get.put(FavoriteController(context));
    return Center(
      child: GetBuilder(
        init:  ProductDetailedController(productId??"",),
        builder: (ProductDetailedController controller) => Scaffold(
          appBar: AppBar(
            backgroundColor:kBackGroundColor,
              leading:
                InkWell(
                  onTap:(){
                    Get.back();
                  },
                  child: Container(
                    child: Row(
                      children:[
                        const Icon(
                          Icons.arrow_back_ios_rounded  ,color:kDarkPinkColor,size:20
                        ),
                        CustomText(
                          goBack.tr,
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
                      ]

                    ),
                  ),
                ),
            actions: [
              InkWell(
                onTap:(){
                  Get.to(()=>ReportScreen(productId: "${controller.productData?.id??0}", storeId: '0',),transition:Transition.upToDown);
                },
                child: Container(
                  child: Row(
                      children:[
                        CustomText(
                        reportTitle.tr,
                        textAlign:TextAlign.left,
                        style:  TextStyle(

                          fontSize: 12,
                          letterSpacing: 0,
                          fontFamily: Get
                              .find<StorageService>()
                              .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                          color: kDarkPinkColor,
                        ),
                      ),
                        const Icon(
                            Icons.report_gmailerrorred  ,color:kDarkPinkColor,size:20
                        ),

                      ]

                  ),
                ),
              ),
            ],


          ),
          backgroundColor:kBackGroundColor,
          floatingActionButton:  controller.productIsLoading?
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7.0),
            child: Container(
              width: Get.width*0.35,
              height: Get.height*0.08,
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

                  width: Get.width*0.32,
                  height: Get.height*0.06,
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
                .animate(),
          ):

          InkWell(
            onTap: (){
              if(controller.productData?.video != ""){
                controller.videoPlayerController.pause();
              }
              Get.to(()=>OrderingScreen(productId: controller.productData?.id??0),transition:Transition.upToDown);
            },
            child: Container(
              width: Get.width*0.35,
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
                ),borderRadius: BorderRadius.circular(40), //
              ),
              child:  Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_cart,
                    weight: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  CustomText(
                    orderNowBTN.tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      shadows: <Shadow>[
                        Shadow(
                            offset: const Offset(2.0, 2.0),
                            blurRadius: 13.0,

                            color: Colors.black.withOpacity(0.5)
                        ),
                      ],
                      fontSize: 18,
                      letterSpacing: 0,
                      fontFamily: Get
                          .find<StorageService>()
                          .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                      color: kBackGroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body:  SafeArea(
            child: SingleChildScrollView(
              controller:controller.scrollController,
              child: Container(
                width:Get.width,
                child: Column(
                  children:[
                    controller.productIsLoading? Container(

                width:Get.width,
                  height:Get.height*0.5,
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
                : controller.productData?.images?.length ==0?const SizedBox():
                    controller.productData?.images?.length ==1? InkWell(
                      onTap:(){
                        Get.to(()=> PhotoDetailedScreen(link: controller.productData!.images,index:-1));
                      },
                      child: Stack(
                        children: [
                          CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl:  "${Services.baseEndPoint}${controller.productData!.images?[0]??""}",
                            imageBuilder: ((context, image){
                              return  Hero(
                                tag:"imageHero${-1}",
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

                          Positioned(
                            right:20,
                            bottom:25,
                            child: InkWell(
                              onTap:(){
                                controller.addingOrRemovingProductToFavorite(context);
                                if(comingFromProductList){
                                  gController.getProductData(false);}
                                if(comingFromFavoriteList){
                                  fController.getData();
                                }

                              },
                              child: Container(
                                  height: Get.height*0.04,
                                  width:Get.width*0.08,
                                  decoration: const BoxDecoration(
                                    color:kLightPinkColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child:controller.productAreAddedOrNot?const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size:14
                                    ):const Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.white,
                                        size:18
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Positioned(
                            left:15,
                            top:20,
                            child: InkWell(
                              onTap:(){
                                Share.share(controller.productData?.link??"");
                              },
                              child: Container(
                                  height: Get.height*0.04,
                                  width:Get.width*0.08,
                                  decoration: const BoxDecoration(
                                    color:kBackGroundColor,
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
                          ),
                        ],
                      ),
                    ):
                    GetBuilder<ProductDetailedController>(
                      id: "Carsoul",
                      builder: (ProductDetailedController controller) {
                        return Stack(
                        children: [

                          CarouselSlider.builder(
                            carouselController: controller.carouselController,
                            itemCount: controller.productData?.images?.length,
                            itemBuilder: (BuildContext context, int index, int realIndex) {
                              return ProductImageWidget(imageUrl: "${controller.productData?.images?[index]??""}", activeIndex: index, imageTotalCount:"${controller.productData?.images?.length??0}",imagesLink:controller.productData?.images);
                            },
                            options: CarouselOptions(
                                height:Get.height*0.5,
                                autoPlay: true,
                                enlargeCenterPage: false,
                                viewportFraction: 1,
                                onPageChanged: (val, _) {
                                  controller.onImageChange(val);
                                }
                            ),
                          ),
                          Positioned(
                            right:20,
                            top:10,
                            child: InkWell(
                              onTap:(){
                                Share.share(controller.productData?.link??"");
                              },
                              child: Container(
                                  height: Get.height*0.04,
                                  width:Get.width*0.08,
                                  decoration: const BoxDecoration(
                                    color:kBackGroundColor,
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
                          ),
                          Positioned(
                            right:20,
                            bottom:25,
                            child: InkWell(
                              onTap:(){
                                controller.addingOrRemovingProductToFavorite(context);
                                if(comingFromProductList){
                                  gController.getProductData(false);}
                                if(comingFromFavoriteList){
                                  fController.getData();
                                }

                              },
                              child: Container(
                                  height: Get.height*0.04,
                                  width:Get.width*0.08,
                                  decoration: const BoxDecoration(
                                    color:kLightPinkColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child:controller.productAreAddedOrNot?const Icon(
                                        Icons.favorite,
                                        color: Colors.white,
                                        size:14
                                    ):const Icon(
                                        Icons.favorite_border_rounded,
                                        color: Colors.white,
                                        size:18
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Positioned(
                            bottom:10,

                            child: Container(

                              width:Get.width,
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.center,
                                children: [
                                  Row(
                                      children:controller.dotsList
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ); },

                    ),
                    Get.find<StorageService>().activeLocale == SupportedLocales.english?Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                          Container(
                            width:Get.width,
                            height:Get.height*0.16,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(10),
                              color:Colors.white,

                            ),
                          ),
                          Positioned(
                            left:0,
                            child: Container(
                                width:Get.width*0.65,
                                height:Get.height*0.15,
                                decoration:BoxDecoration(
                                  borderRadius:BorderRadius.circular(10),
                                  color:Colors.transparent,

                                ),
                                child:Padding(
                                  padding: const EdgeInsets.only(left:10.0,right: 0,top:10,),
                                  child: Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:CrossAxisAlignment.start,
                                      children:[
                                        controller.productIsLoading?Container(
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
                                            .slide().animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide():Container(
                                          width:Get.width*0.55,
                                          child: CustomText(
                                            Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.productData?.nameEn??"":controller.productData?.name??"",
                                            style: TextStyle(
                                              shadows: <Shadow>[
                                                Shadow(
                                                    offset: const Offset(0.5, 0.5),
                                                    blurRadius: 0.5,

                                                    color: Colors.black.withOpacity(0.5)
                                                ),

                                              ],

                                              fontWeight: FontWeight.w900,
                                              fontSize: 16,
                                              letterSpacing: 0,
                                              fontFamily: Get
                                                  .find<StorageService>()
                                                  .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                              color: kDarkPinkColor,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                        controller.productIsLoading?Container(
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
                                            .slide().animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide():InkWell(
                                          onTap: (){
                                            Get.to(()=> StoreDetailedScreen(shopId: "${controller.productData?.shop?.id??0}", mainCategoryId: mainCategoryId, mainCategoryImg:mainCategoryImg,),preventDuplicates: false);
                                          },
                                              child: Container(
                                                                                      width:Get.width*0.55,
                                                                                      child: CustomText(
                                              Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.productData?.shop?.nameEn??"":controller.productData?.shop?.name??"",
                                              style: TextStyle(


                                                fontWeight: FontWeight.w600,
                                                fontSize: 14,
                                                letterSpacing: 0,
                                                fontFamily: Get
                                                    .find<StorageService>()
                                                    .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                                color: Colors.black,
                                              ),
                                              maxLines: 2,
                                                                                      ),
                                                                                    ),
                                            ),
                                        controller.productIsLoading?Container(
                                          width:Get.width*0.25,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFDFDDDF),
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide().animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide():CustomText(
                                          '${priceKey.tr} ${controller.productData?.price} ${currencyKey.tr}',
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
                                        Row(
                                            mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                            children:[
                                              controller.productIsLoading?Container(
                                                width: Get.width*0.09,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFDFDDDF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide().animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide():InkWell(
                                                onTap:(){
                                                  controller.makePhoneCall( '${controller.productData?.shop?.phone}',context);
                                                },
                                                child: Row(
                                                  crossAxisAlignment:CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height*0.037,
                                                      width: Get.width*0.12,
                                                      child: Image.asset("assets/icons/c.png",fit: BoxFit.fitHeight,),
                                                    ),

                                                  ],
                                                ),
                                              ),
                                              controller.productIsLoading?Container(
                                                width: Get.width*0.09,
                                                height: 20,
                                                decoration: const BoxDecoration(
                                                    color: Color(0xFFDFDDDF),
                                                  shape: BoxShape.circle,
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide().animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide():InkWell(
                                                onTap:(){
                                                  controller.whatsapp('${controller.productData?.shop?.whatsapp}',context);
                                                },
                                                child: Row(
                                                  crossAxisAlignment:CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      height: Get.height*0.037,
                                                      width: Get.width*0.13,
                                                      child: Image.asset("assets/icons/w.png",fit: BoxFit.fitHeight,),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              controller.productIsLoading?Container(
                                                width:Get.width*0.25,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide().animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide():RatingBar.builder(
                                                initialRating:double.parse(controller.productData?.rating??"0"),
                                                minRating: double.parse(controller.productData?.rating??"0"),
                                                itemSize:20,
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

                                              controller.productIsLoading?Container(
                                                width: Get.width*0.09,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                    color: const Color(0xFFDFDDDF),
                                                    borderRadius: BorderRadius.circular(50)
                                                ),
                                              ).animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide().animate(onPlay: (controller) => controller.repeat())
                                                  .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                                  .animate() // this wraps the previous Animate in another Animate
                                                  .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                                  .slide(): Row(
                                                  children:[
                                                    CustomText(
                                                      "${controller.productData?.visitors??0}",
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
                                                        Icons.remove_red_eye_outlined  ,color:kDarkPinkColor,size:15
                                                    ),

                                                  ]

                                              )
                                            ]
                                        )
                                      ]
                                  ),
                                )

                            ),
                          ),
                          Positioned(
                            top:0,
                            right:0,
                            child: Container(
                              height:Get.height*0.16,
                              width: Get.width*0.4,
                              decoration:const BoxDecoration(
                                borderRadius:BorderRadius.only(topRight:Radius.circular(10),bottomRight:Radius.circular(10)),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/cakeBG1.png",
                                  ),
                                  fit:  BoxFit.cover,
                                ),

                              ),
                            ),
                          ),
                          Positioned(
                            right:5,
                            child: Container(
                              width:Get.width*0.2,
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.end,
                                children: [

                                  controller.productIsLoading?Padding(
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
                                      : InkWell(
                                    onTap: (){
                                      Get.to(()=> StoreDetailedScreen(shopId: "${controller.productData?.shop?.id??0}", mainCategoryId: mainCategoryId, mainCategoryImg: mainCategoryImg,),preventDuplicates: false);
                                    },
                                        child: CachedNetworkImage(
                                    fit:  BoxFit.contain,
                                    imageUrl: "${Services.baseEndPoint}${controller.productData?.shop?.image??""}",
                                    imageBuilder: ((context, image){
                                        return   Container(
                                            height: Get.height*0.13,
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
                                      ),

                                ],
                              ),
                            ),
                          ),


                        ],
                      ),
                    ):
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Stack(
                        children: [
                        Container(
                        width:Get.width,
                        height:Get.height*0.16,
                          decoration:BoxDecoration(
                            borderRadius:BorderRadius.circular(10),
                            color:Colors.white,

                          ),
                        ),
                          Positioned(
                            top:0,
                            left:0,
                            child: Container(
                              height:Get.height*0.16,
                              width: Get.width*0.4,
                              decoration:const BoxDecoration(
                                borderRadius:BorderRadius.only(topLeft:Radius.circular(10),bottomLeft:Radius.circular(10)),
                                image: DecorationImage(
                                  image: AssetImage(
                                    "assets/images/cakeBG.png",
                                  ),
                                  fit:  BoxFit.cover,
                                ),

                              ),
                            ),
                          ),
                          Positioned(
                            left:5,
                            child: Container(
                              width:Get.width*0.2,
                              child: Row(
                                mainAxisAlignment:MainAxisAlignment.start,
                                crossAxisAlignment:CrossAxisAlignment.end,
                                children: [

                                  controller.productIsLoading?Padding(
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
                                  ) // this wraps the previous Animate in another Animate
                                      :InkWell(
                                    onTap: (){
                                      Get.to(()=> StoreDetailedScreen(shopId: "${controller.productData?.shop?.id??0}", mainCategoryId: mainCategoryId, mainCategoryImg:mainCategoryImg,),preventDuplicates: false);
                                    },
                                        child: CachedNetworkImage(
                                    imageUrl: "${Services.baseEndPoint}${controller.productData?.shop?.image??""}",
                                    imageBuilder: ((context, image){
                                        return   Container(
                                            height: Get.height*0.13,
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
                                          child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitWidth,),
                                        );
                                    },
                                  ),
                                      ),

                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            right:0,
                            child: Container(
                                width:Get.width*0.7,
                                height:Get.height*0.15,
                              decoration:BoxDecoration(
                                borderRadius:BorderRadius.circular(10),
                                color:Colors.transparent,

                              ),
                              child:Padding(
                                padding: const EdgeInsets.only(left:10.0,right: 10,top:10,),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children:[
                                    controller.productIsLoading?Container(
                                      width:Get.width*0.5,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFDFDDDF),
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                    ).animate(onPlay: (controller) => controller.repeat())
                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                        .animate() // this wraps the previous Animate in another Animate
                                        .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                        .slide().animate(onPlay: (controller) => controller.repeat())
                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                        .animate() // this wraps the previous Animate in another Animate
                                        .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                        .slide():Container(
                                      width:Get.width*0.55,
                                          child: CustomText(
                                      Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.productData?.nameEn??"":controller.productData?.name??"",
                                      style: TextStyle(


                                          fontWeight: FontWeight.w900,
                                          fontSize: 16,

                                          fontFamily: Get
                                              .find<StorageService>()
                                              .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                          color: kDarkPinkColor,
                                      ),
                                            maxLines: 2,
                                    ),
                                        ),
                                    controller.productIsLoading?Container(
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
                                        .slide().animate(onPlay: (controller) => controller.repeat())
                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                        .animate() // this wraps the previous Animate in another Animate
                                        .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                        .slide():InkWell(
                                      onTap: (){
                                        Get.to(()=> StoreDetailedScreen(shopId: "${controller.productData?.shop?.id??0}", mainCategoryId: mainCategoryId, mainCategoryImg:mainCategoryImg,),preventDuplicates: false);
                                      },
                                          child: Container(
                                            width:Get.width*0.55,
                                            child: CustomText(
                                          Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.productData?.shop?.nameEn??"":controller.productData?.shop?.name??"",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 14,
                                            letterSpacing: 0,
                                            fontFamily: Get
                                                .find<StorageService>()
                                                .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                            color: Colors.black,
                                          ),
                                          maxLines: 2,
                                                                              ),
                                                                            ),
                                        ),
                                    controller.productIsLoading?Container(
                                      width:Get.width*0.25,
                                      height: 20,
                                      decoration: BoxDecoration(
                                          color: const Color(0xFFDFDDDF),
                                          borderRadius: BorderRadius.circular(50)
                                      ),
                                    ).animate(onPlay: (controller) => controller.repeat())
                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                        .animate() // this wraps the previous Animate in another Animate
                                        .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                        .slide().animate(onPlay: (controller) => controller.repeat())
                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                        .animate() // this wraps the previous Animate in another Animate
                                        .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                        .slide():CustomText(
                                      '${priceKey.tr} ${controller.productData?.price} ${currencyKey.tr}',
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
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,

                                      children:[
                                        controller.productIsLoading?Container(
                                          width: Get.width*0.09,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFDFDDDF),
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide().animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide():InkWell(
                                          onTap:(){
                                            controller.makePhoneCall( '${controller.productData?.shop?.phone}',context);
                                          },
                                          child: Row(
                                            crossAxisAlignment:CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: Get.height*0.035,
                                                width: Get.width*0.1,
                                                child: Image.asset("assets/icons/c.png",fit: BoxFit.fitHeight,),
                                              ),

                                            ],
                                          ),
                                        ),
                                        controller.productIsLoading?Container(
                                          width: Get.width*0.09,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFDFDDDF),
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide().animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide():InkWell(
                                          onTap:(){
                                            controller.whatsapp('${controller.productData?.shop?.whatsapp}',context);
                                          },
                                          child: Row(
                                            crossAxisAlignment:CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: Get.height*0.035,
                                                width: Get.width*0.12,
                                                child: Image.asset("assets/icons/w.png",fit: BoxFit.fitHeight,),
                                              ),
                                            ],
                                          ),
                                        ),
                                        controller.productIsLoading?Container(
                                          width:Get.width*0.25,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFDFDDDF),
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide().animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide():RatingBar.builder(
                                          initialRating:double.parse(controller.productData?.rating??"0"),
                                          minRating: double.parse(controller.productData?.rating??"0"),
                                          itemSize:20,
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
                                        controller.productIsLoading?Container(
                                          width: Get.width*0.09,
                                          height: 20,
                                          decoration: BoxDecoration(
                                              color: const Color(0xFFDFDDDF),
                                              borderRadius: BorderRadius.circular(50)
                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide().animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate() // this wraps the previous Animate in another Animate
                                            .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                                            .slide(): Row(
                                            children:[
                                              CustomText(
                                                "${controller.productData?.visitors??0}",
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
                                      ]
                                    )
                                  ]
                                ),
                              )

                            ),
                          ),

                        ],
                      ),
                    ),
                controller.productIsLoading? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width:Get.width,
                    child: GridView.builder(
                      shrinkWrap:true,
                      controller:controller.scrollController,
                      itemCount: 5,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing:10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio:1.7
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return  Container(
                            height: Get.height*0.02,
                            width:Get.width*0.3,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.white,
                            ),
                            child: Center(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: <Widget>[
                                  Center(
                                    child:   Container(
                                      width:Get.width*0.25,
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
                                      .slide(),
                                  Center(
                                    child:   Container(
                                      width:Get.width*0.25,
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
                                ]
                            ),
                            )
                        );
                      },
                    ),
                  ),
                ):
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width:Get.width,
                    child: GridView.builder(
                      shrinkWrap:true,
                      controller:controller.scrollController,
                      itemCount:controller.productData!.itemFilter?.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing:10.0,
                          mainAxisSpacing: 10.0,
                          childAspectRatio:1.7
                      ),
                      itemBuilder: (BuildContext context, int index){
                        return  Container(
                            height: Get.height*0.02,
                          width:Get.width*0.3,
                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.white,
                            ),
                            child: Center(child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,

                                children: <Widget>[
                                  CustomText(
                                    Get.find<StorageService>().activeLocale == SupportedLocales.english?"${controller.productData!.itemFilter?[index].filterEn??""}":"${controller.productData!.itemFilter?[index].filter??""}",
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
                                      fontWeight: FontWeight.w900,

                                      fontFamily: Get
                                          .find<StorageService>()
                                          .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                      color: kDarkPinkColor,
                                    ),
                                  ),
                                  CustomText(
                                    Get.find<StorageService>().activeLocale == SupportedLocales.english?"${controller.productData!.itemFilter?[index].filterItemEn??""}":"${controller.productData!.itemFilter?[index].filterItem??""}",
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
                                      color: kLightPinkColor,
                                    ),
                                  ),
                                ]
                            ),
                            )
                        );
                      },
                    ),
                  ),
                ),
                    controller.productIsLoading?Container(
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
            .animate():controller.productData?.video==""?const SizedBox() // this wraps the previous Animate in another Animate
        :VideoPlayerWidget(videoPlayer: '${Services.baseEndPoint}${controller.productData?.video??""}', videoPlayerController: controller.videoPlayerController,),
                Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                    width:Get.width,
                    decoration:BoxDecoration(
                      borderRadius:BorderRadius.circular(15),
                      color:Colors.white,
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment:CrossAxisAlignment.start,
                      children: [

                        CustomText(
                          detailsTitle.tr,

                        textAlign:TextAlign.left,
                          style: TextStyle(
                            fontWeight: FontWeight.w900,

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
                        controller.productIsLoading?Center(
                          child:   Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:Get.width*0.85,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:Get.width*0.85,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:Get.width*0.85,
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
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  width:Get.width*0.85,
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
                              ),
                            ],
                          ).animate(onPlay: (controller) => controller.repeat())
                              .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                              .animate() // this wraps the previous Animate in another Animate
                              .fadeIn(duration: 700.ms, curve: Curves.easeOutQuad)
                              .slide(),


                        ): ReadMoreText(  Get.find<StorageService>().activeLocale == SupportedLocales.english?controller.productData?.descEn??"":controller.productData?.desc??"", colorClickableText: kLightPinkColor, style:  const TextStyle(
                          fontSize: 13,
                          letterSpacing: 0,
                          fontFamily: fontFamilyArabicName,
                          color: Colors.black,
                        ), textAlign: TextAlign.center, textDirection: TextDirection.rtl, semanticsLabel: '',trimCollapsedText:readMoreKey.tr,trimExpandedText:readLessKey.tr),
                      ],
                    ),
                  )
                ),
              ),

                Padding(
                padding: const EdgeInsets.all(8.0),
            child: Container(
                width:Get.width*0.95,
                height:Get.height*0.445,
                decoration:BoxDecoration(
                  borderRadius:BorderRadius.circular(15),
                  color:Colors.white,
                ),
              child:Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                  children:[
                    CustomText(
                      otherProductTitle.tr,
                      textAlign:TextAlign.left,
                      style: TextStyle(
                        shadows: <Shadow>[
                          Shadow(
                              offset: const Offset(0.5, 0.5),
                              blurRadius: 0.5,

                              color: Colors.black.withOpacity(0.5)
                          ),
                        ],
                        fontWeight: FontWeight.w900,
                        fontSize: 15,
                        letterSpacing: 0,
                        fontFamily: Get
                            .find<StorageService>()
                            .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                        color: kDarkPinkColor,
                      ),
                    ),
                    controller.productIsLoading?const SellerProductLoadingWidget():controller.productsList?.length == 0?Row(
                        children:[
                          SizedBox(
                            width:Get.width*0.4,
                            height:Get.height*0.36,
                            child: Image.asset("assets/images/Product quality-bro.png",fit: BoxFit.fitWidth,),
                          ),
                          const SizedBox(
                              width:30
                          ),
                          SizedBox(
                            width:Get.width*0.4,
                            child:  CustomText(
                              noProductData.tr,
                              textAlign:TextAlign.center,
                              style:  TextStyle(
                                fontSize:20,
                                fontFamily: Get
                                    .find<StorageService>()
                                    .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                fontWeight: FontWeight.w900,
                                color: kDarkPinkColor,
                              ),
                            ),
                          ),
                        ]
                    ):Container(
                      width:Get.width*0.95,
                      height:Get.height*0.375,
                      child: ListView.builder(
                        scrollDirection:Axis.horizontal,
                        shrinkWrap:true,
                        itemCount:controller.productsList?.length,
                        itemBuilder: (BuildContext context, int index)  {

                          return  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ProductWidget(product:controller.productsList?[index], productAreAddedOrNot:controller.productsList?[index].favorite==1 , addingOrRemovingProductToFavorite: (){
                              controller.addingOrRemovingProductsToFavorite(context, "${controller.productsList?[index].id}",index);
                            }, mainCategoryId: mainCategoryId, comingFromProductDetails: true, comingFromFavoriteList: false, comingFromProductList: false, branchCategoryId: branchCategoryId,productDetailsFunction: (){


                            }, mainCategoryImg: mainCategoryImg,),
                          );
                        },

                      ),
                    )
                  ]
                ),
              )

            )

                ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width:Get.width*0.95,

                            decoration:BoxDecoration(
                              borderRadius:BorderRadius.circular(15),
                              color:Colors.white,
                            ),
                            child:Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                  crossAxisAlignment:CrossAxisAlignment.start,
                                  children:[
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        CustomText(
                                          commentsTitle.tr,
                                          textAlign:TextAlign.left,
                                          style: TextStyle(
                                            shadows: <Shadow>[
                                              Shadow(
                                                  offset: const Offset(0.5, 0.5),
                                                  blurRadius: 0.5,

                                                  color: Colors.black.withOpacity(0.5)
                                              ),
                                            ],
                                            fontWeight: FontWeight.w900,
                                            fontSize: 15,
                                            letterSpacing: 0,
                                            fontFamily: Get
                                                .find<StorageService>()
                                                .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                            color: kDarkPinkColor,
                                          ),
                                        ),
                                       controller.comments!.length <= 5?const SizedBox(): InkWell(
                                         onTap:(){
                                           Get.to(() =>CommentsScreen(comments:controller.comments,));
                                         },
                                         child: CustomText(
                                            readMoreKey.tr,
                                            textAlign:TextAlign.right,
                                            style: TextStyle(
                                              shadows: <Shadow>[
                                                Shadow(
                                                    offset: const Offset(0.5, 0.5),
                                                    blurRadius: 0.5,

                                                    color: Colors.black.withOpacity(0.5)
                                                ),
                                              ],
                                              fontWeight: FontWeight.w900,
                                              fontSize: 15,
                                              letterSpacing: 0,
                                              fontFamily: Get
                                                  .find<StorageService>()
                                                  .activeLocale == SupportedLocales.english ?fontFamilyEnglishName:fontFamilyArabicName,
                                              color: kDarkPinkColor,
                                            ),
                                          ),
                                       ),
                                      ],
                                    ),
                                    controller.productIsLoading?const CommentLoadingWidget():controller.comments?.length == 0?Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  Image.asset("assets/images/Online Review-rafiki.png",height: Get.width*0.23,),
                                  CustomText(noReviews.tr,style: const TextStyle(color: kDarkPinkColor,fontWeight: FontWeight.bold,fontSize: 18),textAlign: TextAlign.center,),
                                ],): Container(
                                      width:Get.width*0.95,


                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,

                                        child: Row(
                                          children: controller.comments!.map((e){
                                            return CommentWidget(data: e, isStoreComment: false,);
                                          }).toList(),
                                        ),
                                      ),

                                    )
                                  ]
                              ),
                            )

                        )

                    ),
            ]
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
