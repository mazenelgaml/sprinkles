// ignore_for_file: empty_catches

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:map_launcher/map_launcher.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/comment_model.dart';
import 'package:untitled/models/favorite_model.dart';
import 'package:untitled/models/products_model.dart';
import 'package:untitled/models/response_model.dart';
import 'package:untitled/models/shop_detailed_model.dart';
import 'package:untitled/services/favorite_services.dart';
import 'package:untitled/services/reviews_services.dart';
import 'package:untitled/services/shop_services.dart';
import 'package:untitled/services/stats_services.dart';
import 'package:untitled/ui/branches_list/branches_list_screen.dart';
import 'package:untitled/ui/login/login_screen.dart';
import 'package:untitled/ui/product_screen/widgets/product_widget.dart';
import 'package:untitled/ui/siginup/signup_screen.dart';
import 'package:untitled/widgets/alert_dialogue.dart';
import 'package:untitled/widgets/yes_or_no_dialogue.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreDetailedController extends GetxController{
 bool shopIsLoading = true;
 bool shopProductIsLoading = true;
 late List<ProductsModel>? productList;
 List<CommentModel>? comments = [];
 late ShopDetailedModel? shopData;
 int selectedSubCategoryId = 0;
 String selectedCategoryImage = "";
 List<Widget> products = [];
 bool storeAreAddedOrNot = false;
 GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
 final String shopId;
 final int mainCategoryId;
 final BuildContext context;
 ScrollController scrollController = ScrollController();
 bool isVisible = false;

 final String mainCategoryImg;
  StoreDetailedController({required this.context, required this.mainCategoryId, required this.shopId,required this.mainCategoryImg, });

 @override
  Future<void> onInit() async {
   super.onInit();
   await getData();
   scrollController.addListener(() {
     if (scrollController.position.userScrollDirection ==
         ScrollDirection.reverse) {
       if (isVisible == true) {

         isVisible = false;
         update();
       }
     } else {
       if (scrollController.position.userScrollDirection ==
           ScrollDirection.forward) {
         if (isVisible == false) {

           isVisible = true;
           update();
         }
       }
     }
   });
 }

 goUpToTopOfSScreen(){
   scrollController.animateTo( //go to top of scroll
       0,  //scroll offset to go
       duration: const Duration(milliseconds: 500), //duration of scroll
       curve:Curves.fastOutSlowIn //scroll type
   );
   isVisible = false;
   update();
 }
 selectingAnotherSubCategory(CategoryModel subCategoryId){
   selectedSubCategoryId = subCategoryId.id??0;
   selectedCategoryImage = subCategoryId.img2??"";
   getProductData(true);

 }

getData() async {
  shopData = await ShopServices.getShopDetails(shopId);
  comments = await ReviewsServices().getStoreComment(shopId);
  if(shopData?.ctgs?.length == 2){
    selectedSubCategoryId = shopData?.ctgs?[1].id??0;
    selectedCategoryImage = shopData?.ctgs?[1].img2??"";
  }else{
    selectedSubCategoryId = shopData?.ctgs?[0].id??0;
    selectedCategoryImage = shopData?.ctgs?[0].img2??"";
  }

  await checkStoreAddedOrNet();
  shopIsLoading=false;
  getProductData(true);
  update();
}
 getProductData(bool changingTap) async {

   if(changingTap) {
     shopProductIsLoading = true;
     update();
   }
       productList = await ShopServices.getProductsOfTheShop(shopId,"$selectedSubCategoryId");
   await fillingData();
   shopProductIsLoading = false;
   update();
   }
  showStoreLocation() async {
    await MapLauncher.showMarker(
      mapType: Platform.isAndroid
          ?MapType.google:MapType.apple,
      coords: Coords(double.parse( shopData?.locationLat??"0.0"), double.parse( shopData?.locationLon??"0.0")),
      title: " ${storeLocation.tr} ${ Get.find<StorageService>().activeLocale == SupportedLocales.english?shopData?.nameEn:shopData?.name}",
      description: " ${storeLocation.tr} ${ Get.find<StorageService>().activeLocale == SupportedLocales.english?shopData?.nameEn:shopData?.name}",
    );
  }
 Future<void> makePhoneCall() async {
   if(shopData?.branch?.length != 0){
     var androidUrl = "whatsapp://send?phone=${shopData?.whatsapp}&text=${'I saw your store in the Sprinkles app and I want to inquire about something \n رأيت متجرك فى تطبيق سبرينكلز  وأريد الاستفسار عن شئ'}";
     var iosUrl = "https://wa.me/${shopData?.whatsapp}?text=${Uri.parse('I saw your store in the Sprinkles app and I want to inquire about something \n رأيت متجرك فى تطبيق سبرينكلز  وأريد الاستفسار عن شئ')}";
     showDialog(context: context,
       builder: (context) =>
           BranchesListWidget(branch: shopData?.branch, androidUrl:androidUrl, iosUrl: iosUrl, shopId: "${shopData?.id??0}", productId: "0",),);
   }
   else {
     var result = await StatsServices().sendingOrderNowOrWhatsAppOrCallHasBeenClicked("${shopData?.id??0}", "0", OrderType.CALL.name, "0");
     if(result?.status == "true") {
       final Uri launchUri = Uri(
         scheme: 'tel',
         path: shopData?.phone,
       );
       await launchUrl(launchUri);

     }

   }

 }
 fillingData()  async {
   products = [];

   for (int i = 0; i <= productList!.length-1; i=i+2) {
     if(i<productList!.length-1){
       products.add(
           Padding(
             padding:const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
             child: Row(
                 mainAxisAlignment:MainAxisAlignment.spaceAround,
                 children:[
                   ProductWidget(product:productList?[i], productAreAddedOrNot:  productList?[i].favorite == 1 , addingOrRemovingProductToFavorite: (){
                     addingOrRemovingProductToFavorite(context,"${productList?[i].id}",i,true,);
                   }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId,  mainCategoryImg: mainCategoryImg,),

                   ProductWidget(product:productList?[i+1], productAreAddedOrNot:  productList?[i+1].favorite == 1 , addingOrRemovingProductToFavorite: (){
                     addingOrRemovingProductToFavorite(context,"${productList?[i+1].id}",i,true);
                   }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
                 ]
             ),
           )
       );

     }
     else{

       products.add(
           Column(
             children: [
               Row(
                   mainAxisAlignment:MainAxisAlignment.start,
                   children:[
                     Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: ProductWidget(product:productList?[i], productAreAddedOrNot: productList?[i].favorite == 1 , addingOrRemovingProductToFavorite: (){
                           addingOrRemovingProductToFavorite(context,"${productList?[i].id}",i,false);
                         }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
                     ),

                   ]
               ),

             ],
           )
       );
     }

   }
 }
 Future<bool> checkProductAddedOrNet(String productId) async {
   FavoriteStatusModel? data= await  FavoriteServices.getProductIsInFavoriteOrNot(productId);
   if(data?.status == 1){
     return true;
   }else{
     return false;
   }
 }
 addingOrRemovingProductToFavorite(context,String productId,int index,bool doubleProductOrNot) async {
   var i = 0;
   if(index != 0){
     i = index - 1;
   }
   if(Get.find<StorageService>().checkUserIsSignedIn){
     if( await checkProductAddedOrNet(productId)){
       ResponseModel? data = await FavoriteServices.addOrRemoveProductFromFavorite(productId,"0");
       if(data?.msg != "succeeded"){
         showDialog(context: context,
             builder: (context) {
               return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight: Get.height*0.4);
             }
         );
       }
       if(doubleProductOrNot){
         var checker =await checkProductAddedOrNet("${productList?[index].id}");
         var checker1 =await checkProductAddedOrNet("${productList?[index+1].id}");
         products[i]=Padding(
           padding:const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
           child: Row(
               mainAxisAlignment:MainAxisAlignment.spaceAround,
               children:[
                 ProductWidget(product:productList?[index], productAreAddedOrNot: checker , addingOrRemovingProductToFavorite: (){
                   addingOrRemovingProductToFavorite(context,"${productList?[index].id}",index,true);
                 }, mainCategoryId: mainCategoryId, comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true, branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,),

                 ProductWidget(product:productList?[index+1], productAreAddedOrNot: checker1 , addingOrRemovingProductToFavorite: (){
                   addingOrRemovingProductToFavorite(context,"${productList?[index+1].id}",index,true);
                 }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
               ]
           ),
         );
         update();
       }else{
         var checker =await checkProductAddedOrNet("${productList?[index].id}");
         products[i]=Column(
           children: [
             Row(
                 mainAxisAlignment:MainAxisAlignment.start,
                 children:[
                   Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: ProductWidget(product:productList?[index], productAreAddedOrNot: checker , addingOrRemovingProductToFavorite: (){
                         addingOrRemovingProductToFavorite(context,"${productList?[index].id}",index,false);
                       }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
                   ),

                 ]
             ),

           ],
         );
         update();
       }

     }else{
       ResponseModel? data = await FavoriteServices.addOrRemoveProductFromFavorite(productId,"1");
       if(data?.msg != "succeeded"){
         showDialog(context: context,
             builder: (context) {
               return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight: Get.height*0.4);
             }
         );
       }else{
         if(doubleProductOrNot){
           var checker =await checkProductAddedOrNet("${productList?[index].id}");
           var checker1 =await checkProductAddedOrNet("${productList?[index+1].id}");
           products[i]=Padding(
             padding:const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
             child: Row(
                 mainAxisAlignment:MainAxisAlignment.spaceAround,
                 children:[
                   ProductWidget(product:productList?[index], productAreAddedOrNot: checker , addingOrRemovingProductToFavorite: (){
                     addingOrRemovingProductToFavorite(context,"${productList?[index].id}",index,true);
                   }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,),

                   ProductWidget(product:productList?[index+1], productAreAddedOrNot: checker1 , addingOrRemovingProductToFavorite: (){
                     addingOrRemovingProductToFavorite(context,"${productList?[index+1].id}",index,true);
                   }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
                 ]
             ),
           );
           update();
         }else{
           var checker =await checkProductAddedOrNet("${productList?[index].id}");
           products[i]=Column(
             children: [
               Row(
                   mainAxisAlignment:MainAxisAlignment.start,
                   children:[
                     Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: ProductWidget(product:productList?[index], productAreAddedOrNot: checker , addingOrRemovingProductToFavorite: (){
                           addingOrRemovingProductToFavorite(context,"${productList?[index].id}",index,false);
                         }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
                     ),

                   ]
               ),

             ],
           );
           update();
         }
       }
     }

   }else{
     showWarningFavorite(context);
   }
 }
 showWarningFavorite(context){
   showDialog(context: context,
       builder: (context) {
         return YesOrNoDialogue(alertText: addToFavoriteValue.tr, alertTitle: addToFavoriteTitle.tr, alertYesButtonTitle: signUpProfile.tr, alertNoButtonTitle: signInProfile.tr, alertYesButtonWidth: Get.width*0.5, alertNoButtonWidth: Get.width*0.5, alertYesButtonFunction: (){
           Get.to(()=>const SignupScreen());
         }, alertNoButtonFunction: (){
           Get.to(()=>LoginScreen());
         }, alertYesButtonIcon: 'assets/icons/signUpIconDrawer.png', alertNoButtonIcon: 'assets/icons/loginIcon.png', alertIcon: 'assets/icons/favoriteIcon.png',containerHeight:Get.height <= 800? Get.height*0.6: Get.height*0.5);
       });
 }
 whatsapp() async{
   if(shopData?.branch?.length != 0){
     var androidUrl = "whatsapp://send?phone=${shopData?.whatsapp}&text=${'I saw your store in the Sprinkles app and I want to inquire about something \n رأيت متجرك فى تطبيق سبرينكلز  وأريد الاستفسار عن شئ'}";
     var iosUrl = "https://wa.me/${shopData?.whatsapp}?text=${Uri.parse('I saw your store in the Sprinkles app and I want to inquire about something \n رأيت متجرك فى تطبيق سبرينكلز  وأريد الاستفسار عن شئ')}";
     showDialog(context: context,
       builder: (context) =>
           BranchesListWidget(branch: shopData?.branch, androidUrl:androidUrl, iosUrl: iosUrl, shopId: "${shopData?.id??0}", productId: "0",),);
   }
   else {
     var androidUrl = "whatsapp://send?phone=${shopData?.whatsapp}&text=${'I saw your store in the Sprinkles app and I want to inquire about something \n رأيت متجرك فى تطبيق سبرينكلز  وأريد الاستفسار عن شئ'}";
     var iosUrl = "https://wa.me/${shopData?.whatsapp}?text=${Uri.parse('I saw your store in the Sprinkles app and I want to inquire about something \n رأيت متجرك فى تطبيق سبرينكلز  وأريد الاستفسار عن شئ')}";
     var result = await StatsServices().sendingOrderNowOrWhatsAppOrCallHasBeenClicked(shopId, "0", OrderType.WHATSAPP.name, "0");
     if(result?.status == "true") {
       try{
         if(Platform.isIOS){
           await launchUrl(Uri.parse(iosUrl));
         }
         else{
           await launchUrl(Uri.parse(androidUrl));
         }
       } on Exception{

       }
     }

   }

 }
 checkStoreAddedOrNet() async {
   FavoriteStatusModel? data= await  FavoriteServices.getShopIsInFavoriteOrNot(shopId);
   if(data?.status == 1){
     storeAreAddedOrNot = true;
   }else{
     storeAreAddedOrNot = false;
   }
 }
 addingOrRemovingStoreToFavorite(context) async {
   if(Get.find<StorageService>().checkUserIsSignedIn){
     if(storeAreAddedOrNot){
       ResponseModel? data = await FavoriteServices.addOrRemoveProductFromFavorite(shopId,"0");
       if(data?.msg != "succeeded"){
         showDialog(context: context,
             builder: (context) {
               return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight: Get.height*0.4);
             }
         );
       }
       await checkStoreAddedOrNet();
       update();
     }else{
       ResponseModel? data = await FavoriteServices.addOrRemoveProductFromFavorite(shopId,"1");
       if(data?.msg != "succeeded"){
         showDialog(context: context,
             builder: (context) {
               return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight: Get.height*0.4);
             }
         );
       }
       await checkStoreAddedOrNet();
       update();
     }
   }else{
     showWarningFavorite(context);
   }
 }

}
