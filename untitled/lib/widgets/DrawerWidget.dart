// ignore_for_file: file_names, library_private_types_in_public_api, use_build_context_synchronously, sized_box_for_whitespace, prefer_typing_uninitialized_variables
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:share_plus/share_plus.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/models/response_model.dart';
import 'package:untitled/services/auth_services.dart';
import 'package:untitled/services/biomatrics_auth_services.dart';
import 'package:untitled/ui/favorite_screen/favorite_screen.dart';
import 'package:untitled/ui/filter/controller/filter_controller.dart';
import 'package:untitled/ui/filter/filter_screen.dart';
import 'package:untitled/ui/home_screen/home_screen.dart';
import 'package:untitled/ui/login/login_screen.dart';
import 'package:untitled/ui/privacypolicy/privacyPolicyScreen.dart';
import 'package:untitled/ui/product_screen/controller/product_contoller.dart';
import 'package:untitled/ui/product_screen/product_screen.dart';
import 'package:untitled/ui/profile/profile_screen.dart';
import 'package:untitled/ui/purchase_history/purchase_history_screen.dart';
import 'package:untitled/ui/siginup/signup_screen.dart';
import 'package:untitled/ui/splash_screen/splash_screen.dart';
import 'package:untitled/ui/store%20_screen/controller/store_controller.dart';
import 'package:untitled/ui/store%20_screen/store_screen.dart';
import 'package:untitled/ui/term&condition/terms_screen.dart';
import 'package:untitled/widgets/alert_dialogue.dart';
import 'package:untitled/widgets/drawer_tap_widget.dart';
import 'package:untitled/widgets/yes_or_no_dialogue.dart';
import '../Utils/constant.dart';
import 'custom_text_widget.dart';


class AppDrawers extends StatefulWidget {

  const AppDrawers({Key? key, required this.scaffoldKey}) : super(key: key);
  final scaffoldKey ;
  @override
  _AppDrawersState createState() => _AppDrawersState();
}

class _AppDrawersState extends State<AppDrawers> {

  String userNameText = '';
  List<DrawerItem> data= [
   DrawerItem(drawerTag1.tr,"homeIconDrawer.png"),
   DrawerItem(drawerTag2.tr,"storeIconDrawer.png"),
   DrawerItem(drawerTag3.tr,"productIconDrawer.png"),
  Get.find<StorageService>().checkUserIsSignedIn?
   DrawerItem(drawerTag4.tr,"userIcon.png"):
   DrawerItem(drawerTag5.tr,"loginIcon.png"),
    Get.find<StorageService>().checkUserIsSignedIn?
    DrawerItem(drawerTag6.tr,"logoutIcon.png"):
    DrawerItem(drawerTag7.tr,"signUpIconDrawer.png"),
    DrawerItem(advancedSearchTitle.tr,"searchIconDrawer.png"),
   DrawerItem(drawerTag8.tr,"privacyIconDrawer.png"),
   DrawerItem(drawerTag9.tr,"termsIconDrawer.png"),
   DrawerItem(drawerTag11.tr,"shareIcon.png"),
   DrawerItem(drawerTag10.tr,"rateIconDrawer.png"),
];
  @override
  void initState() {
    super.initState();
  if(Get.find<StorageService>().checkUserIsSignedIn){
      data.insert(5,  DrawerItem(favTitle.tr,"favoriteIcon.png"));
      data.insert(6,  DrawerItem(drawerTag12.tr,"user_history-icon.png"));
      userNameText = Get.find<StorageService>().userName;
      setState(() {
      });
  }


  }
  detectFunctionalityOfDrawerTap(String title) async {
    bool test4 = Get.isRegistered<ProductController>();
    if(test4){
      Get.delete<ProductController>();
    }
    bool test3 = Get.isRegistered<StoreController>();
    if(test3){
      Get.delete<StoreController>();
    }
    switch (title) {
      case"البحث المتقدم":{
        bool test4 = Get.isRegistered<FilterController>();
        if(test4){
          Get.delete<FilterController>();
        }
        Get.to(() => const FilterScreen(),
            transition: Transition.rightToLeftWithFade);

        widget.scaffoldKey.currentState?.openEndDrawer();
      }
      break;
      case "الرئيسيّة":
        {
          Get.to(() => const HomeScreen(),
              transition: Transition.rightToLeftWithFade);

          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "عرض المحلات":
        {
          Get.to(() =>
          const StoreScreen(selectedFromDrawer: true, mainCategoryId: 0, mainCategoryImg: '',),
              transition: Transition.rightToLeftWithFade, preventDuplicates: false);

          widget.scaffoldKey.currentState?.openEndDrawer();
        }
      case "قائمة المفضلة":
        {
          Get.to(() => const FavoriteScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "الحساب الشخصى":
        {
          Get.to(() => const ProfileScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;

      case "سياسة الخصوصية":
        {
          Get.to(() => const PrivacyPolicyScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
      case "الأحكام والشروط":
        {
          Get.to(() => const TermsScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "عرض المنتجات ":
        {
          Get.to(() =>
          const ProductScreen(mainCategoryId: 0, selectingFromDrawer: true, mainCategoryImg: '',),
              transition: Transition.rightToLeftWithFade,preventDuplicates: false);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "تسجيل دخول":
        {
          Get.to(() => LoginScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "انشاء حساب":
        {
          Get.to(() => const SignupScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "شارك التطبيق":
        {

            Share.share(Platform.isAndroid
                ? "https://play.google.com/store/apps/details?id=com.Sync.sprinkles"
                : "https://apps.apple.com/us/app/sprinkles/id6468032576",);

          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "الطلبات":
        {
          Get.to(() => const PurchaseHistoryScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case"Advanced Search":{
        bool test4 = Get.isRegistered<FilterController>();
        if(test4){
          Get.delete<FilterController>();
        }
      Get.to(() => const FilterScreen(),
          transition: Transition.rightToLeftWithFade);

      widget.scaffoldKey.currentState?.openEndDrawer();
    }break;
      case "Orders":
        {
          Get.to(() => const PurchaseHistoryScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Share the app":
        {

            Share.share(Platform.isAndroid
                ? "https://play.google.com/store/apps/details?id=com.Sync.sprinkles"
                : "https://apps.apple.com/us/app/sprinkles/id6468032576",);

          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "تسجيل الخروج":
        {
          showDialog(context: context,
              builder: (context) {
                return YesOrNoDialogue(alertText: logOutWarning.tr,
                    alertTitle: drawerTag6.tr,
                    alertYesButtonTitle: drawerTag6.tr,
                    alertNoButtonTitle: deleteAcc.tr,
                    alertYesButtonWidth: Get.width * 0.5,
                    alertNoButtonWidth: Get.width * 0.5,
                    alertYesButtonFunction: () {
                      Get.find<StorageService>().loggingOut();
                      Get.offAll(() => const SplashScreen());
                    },
                    alertNoButtonFunction: () async {
                      if (await BiomatricsAuthService.authenticateUser(
                          deleteAcc.tr)) {
                        ResponseModel? data = await AuthServices
                            .deleteUserAccount(Get
                            .find<StorageService>()
                            .getId);
                        if (data?.msg == "succeeded") {
                          Get.find<StorageService>().loggingOut();
                          Get.offAll(() => const SplashScreen());
                        }
                        else {
                          showDialog(context: context,
                              builder: (context) {
                                return AlertDialogue(alertTitle: errorKey.tr,
                                    alertText: Get
                                        .find<StorageService>()
                                        .activeLocale == SupportedLocales
                                        .english
                                        ? data?.msg ?? ""
                                        : data?.msgAr ?? "",
                                    alertIcon: "assets/icons/warningIcon.png",
                                    containerHeight: Get.height*0.4);
                              }
                          );
                        }
                      }
                    },
                    alertYesButtonIcon: 'assets/icons/logoutIcon.png',
                    alertNoButtonIcon: 'assets/icons/deleteAccountIcon.png',
                    alertIcon: 'assets/icons/logoutIcon.png',
                    containerHeight: Get.height <= 800? Get.height * 0.57:Get.height * 0.5);
              });
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Home":
        {
          Get.to(() => const HomeScreen(),
              transition: Transition.rightToLeftWithFade);

          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Shop Display":
        {
          Get.to(() =>
          const StoreScreen(selectedFromDrawer: true, mainCategoryId: 0, mainCategoryImg: '',),
              transition: Transition.rightToLeftWithFade,preventDuplicates: false);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
      case 'Favorites list':
        {
          Get.to(() => const FavoriteScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Personal Account":
        {
          Get.to(() => const ProfileScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;

      case "Privacy Policy":
        {
          Get.to(() => const PrivacyPolicyScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
      case "Terms and Conditions":
        {
          Get.to(() => const TermsScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Display Products":
        {
          Get.to(() =>
          const ProductScreen(mainCategoryId: 0, selectingFromDrawer: true, mainCategoryImg: '',),
              transition: Transition.rightToLeftWithFade,preventDuplicates: false);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Log in":
        {
          Get.to(() => LoginScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Create an account":
        {
          Get.to(() => const SignupScreen(),
              transition: Transition.rightToLeftWithFade);
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "Log out":
        {
          showDialog(context: context,
              builder: (context) {
                return YesOrNoDialogue(alertText: logOutWarning.tr,
                    alertTitle: drawerTag6.tr,
                    alertYesButtonTitle: drawerTag6.tr,
                    alertNoButtonTitle: deleteAcc.tr,
                    alertYesButtonWidth: Get.width * 0.5,
                    alertNoButtonWidth: Get.width * 0.5,
                    alertYesButtonFunction: () {
                      Get.find<StorageService>().loggingOut();
                      Get.offAll(() => const SplashScreen());
                    },
                    alertNoButtonFunction: () async {
                      if (await BiomatricsAuthService.authenticateUser(
                          deleteAcc.tr)) {
                        ResponseModel? data = await AuthServices
                            .deleteUserAccount(Get
                            .find<StorageService>()
                            .getId);
                        if (data?.msg == "succeeded") {
                          Get.find<StorageService>().loggingOut();
                          Get.offAll(() => const SplashScreen());
                        }
                        else {
                          showDialog(context: context,
                              builder: (context) {
                                return AlertDialogue(alertTitle: errorKey.tr,
                                    alertText: Get
                                        .find<StorageService>()
                                        .activeLocale == SupportedLocales
                                        .english
                                        ? data?.msg ?? ""
                                        : data?.msgAr ?? "",
                                    alertIcon: "assets/icons/warningIcon.png",
                                    containerHeight: Get.height * 0.4);
                              }
                          );
                        }
                      }
                    },
                    alertYesButtonIcon: 'assets/icons/logoutIcon.png',
                    alertNoButtonIcon: 'assets/icons/deleteAccountIcon.png',
                    alertIcon: 'assets/icons/logoutIcon.png',
                    containerHeight: Get.height <= 700? Get.height * 0.57:Get.height * 0.5);
              });
          widget.scaffoldKey.currentState?.openEndDrawer();
        }
        break;
      case "App Rating":
        {
          final InAppReview inAppReview = InAppReview.instance;
          if (await inAppReview.isAvailable()) {
            inAppReview.openStoreListing(
              appStoreId: 'com.syncqatar.sprinkles',
              microsoftStoreId: '...',
            );
          }
        }
        break;
      case "تقييم التطبيق":
        {
          final InAppReview inAppReview = InAppReview.instance;
          if (await inAppReview.isAvailable()) {
            inAppReview.openStoreListing(
              appStoreId: 'com.syncqatar.sprinkles',
              microsoftStoreId: '...',
            );
          }
        }
        break;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(

      backgroundColor: kBackGroundColor,
      child: ListView(
        children: [
          Stack(

              children:[
                Container(
                  height: Get.height*0.17,
                  width:Get.width,

                ),
                Positioned(
                  top:0,
                  right:0, child: Container(
          height: Get.height*0.25,
          width:Get.width*0.45,
          child:  Padding(
            padding: const EdgeInsets.fromLTRB(8.0,0,8.0,0),
            child: Column(
                crossAxisAlignment:CrossAxisAlignment.start,

                children:[
                CustomText(
                  greetingText.tr,
                  style: const TextStyle(

                    fontSize: 17,
                    letterSpacing: 0,
                    fontFamily: fontFamilyArabicName,
                    color: kDarkPinkColor,
                  ),
                ),
                Center(
                  child: CustomText(
                    userNameText,
                    style: const TextStyle(

                      fontSize: 15,
                      letterSpacing: 0,
                      fontFamily: fontFamilyArabicName,
                      color: kDarkPinkColor,
                    ),
                  ),
                ),
              ]
            ),
          )),),
                Positioned(
                  top:0-5,
                  left:0,
                  child: Stack(
                    children: [
                      Container(
                        height: Get.height*0.157,
                        width: Get.width*0.4,
                      ),
                      Positioned(
                        top:0,
                        child: SizedBox(
                          height: Get.height*0.157,
                          width: Get.width*0.4,
                          child: Image.asset("assets/images/cakeBG.png",fit: BoxFit.fitWidth,),
                        ),
                      ),
                      Positioned(
                        left:5,
                        child: Container(
                          width:Get.width*0.22,
                          child: Row(
                            mainAxisAlignment:MainAxisAlignment.start,
                            crossAxisAlignment:CrossAxisAlignment.end,
                            children: [


                              Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                height: Get.height*0.12,
                                width: Get.width*0.22,
                                child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.fitWidth,),
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
          Column(
            children:data.map((e){
              return InkWell(
                onTap:(){
                  detectFunctionalityOfDrawerTap(e.title);
                },
                  child: DrawerTapWidget(title: e.title, iconPath: 'assets/icons/${e.iconName}',));

            }).toList(),
          )
        ],
      ),
    );
  }
}
class DrawerItem {
  const DrawerItem(this.title, this.iconName);

  final String title;
  final String iconName;
}