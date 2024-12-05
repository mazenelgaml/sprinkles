import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/favorite_model.dart';
import 'package:untitled/models/main_category_data.dart';
import 'package:untitled/models/response_model.dart';
import 'package:untitled/models/shops_model.dart';
import 'package:untitled/services/category_services.dart';
import 'package:untitled/services/favorite_services.dart';
import 'package:untitled/services/product_service.dart';
import 'package:untitled/services/seaarch_and_filters_services.dart';
import 'package:untitled/services/shop_services.dart';
import 'package:untitled/ui/login/login_screen.dart';
import 'package:untitled/ui/siginup/signup_screen.dart';
import 'package:untitled/ui/store%20_screen/widget/store_widget.dart';
import 'package:untitled/widgets/alert_dialogue.dart';
import 'package:untitled/widgets/yes_or_no_dialogue.dart';

class StoreController extends GetxController {
  FocusNode myFocusNode = FocusNode();
  bool storeIsLoading = true;
  bool categoryIsLoading = true;
  bool advertisementsIsLoading = true;
  late TextEditingController searchController;

  late MainCategoryTapModel? data;
  final int mainCategoryId;
  final bool selectedFromDrawer;
  List<Widget> storeListWidget = [];
  final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  final BuildContext context;
  final String mainCategoryImg;
  StoreController(this.mainCategoryId, this.selectedFromDrawer, this.context, this.mainCategoryImg);
  bool checker =false;
  bool hasBeenSelectedFromDrawer = false;
  int selectedMainCategoryId = 240;
  late List<ShopsModel>? storeList;
  late List<CategoryModel>? mainCategoryList;
  List<String> governmentData = [removeFilterTitle.tr,nameFilterDescTitle.tr,nameFilterAscTitle.tr,];
  String selectingFilterTag = "0";
  String selectingFilterTagName = removeFilterValue.tr;
  ScrollController scrollController = ScrollController();
  bool activateSearching = false;
  bool isVisible = false;
  @override
  Future<void> onInit() async {
    super.onInit();
    getSubCategoryData();
    hasBeenSelectedFromDrawer = selectedFromDrawer;
    myFocusNode.addListener( () {
      update();
    });
    searchController = TextEditingController();
    if(selectedFromDrawer){
    await getMainCategoryData();
    }
    await   getStoreData(true);
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
  getSubCategoryData() async {
    if(selectedFromDrawer){
    if(selectedMainCategoryId!=240){
      data = await ProductServices.getMainProductData("$selectedMainCategoryId");
      categoryIsLoading = false;
      update();
    }}else{
      data = await ProductServices.getMainProductData("${mainCategoryId}");
      categoryIsLoading = false;
      update();
    }

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
  changeFiltersData(){
    selectingFilter(selectingFilterTagName,true);
    governmentData = [removeFilterTitle.tr,nameFilterDescTitle.tr,nameFilterAscTitle.tr,];
  }
  selectingFilter(String filterName,bool changingLanguageOnly) async {
    switch(filterName){
      case "ترتيب حسب":{
        selectingFilterTag = "0";
        selectingFilterTagName = removeFilterValue.tr;
      }
      break;
      case "Sort by":{
        selectingFilterTag = "0";
        selectingFilterTagName = removeFilterValue.tr;
      }
      break;
      case"ازاله ترتيب حسب":{
        selectingFilterTag = "0";
        selectingFilterTagName = removeFilterValue.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            await getStoreData(true);
          }
        }
      }
      break;

      case"ترتيب حسب الاسم من ى إلى أ":{
        selectingFilterTag =  Get.find<StorageService>().activeLocale == SupportedLocales.english?Filters.name_en_desc.name:Filters.name_desc.name;
        selectingFilterTagName = nameFilterDescTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            await getStoreData(true);
          }
        }
      }
      break;
      case"ترتيب حسب الاسم من أ إلى ى":{
        selectingFilterTag =  Get.find<StorageService>().activeLocale == SupportedLocales.english?Filters.name_en_asc.name:Filters.name_asc.name;
        selectingFilterTagName = nameFilterAscTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            await getStoreData(true);
          }
        }
      }
      break;
      case "Remove sort order":{
        selectingFilterTag = "0";
        selectingFilterTagName = removeFilterValue.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            await getStoreData(true);
          }
        }
      }
      break;

      case "Sort by name from Z to A":{
        selectingFilterTag =  Get.find<StorageService>().activeLocale == SupportedLocales.english?Filters.name_en_desc.name:Filters.name_desc.name;
        selectingFilterTagName = nameFilterDescTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            await getStoreData(true);
          }
        }
      }
      break;
      case "Sort by name from A to Z":{
        selectingFilterTag =  Get.find<StorageService>().activeLocale == SupportedLocales.english?Filters.name_en_asc.name:Filters.name_asc.name;
        selectingFilterTagName = nameFilterAscTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            await getStoreData(true);
          }
        }
      }
      break;
    }
  }
  String removeAllWhitespaces(String string) {
    return string.replaceAll(' ', '');
  }
  searchingForKeyword() async {
    if(removeAllWhitespaces(searchController.text)==""){
      activateSearching = false;
      getStoreData(true);
    }else{

      storeIsLoading = true;
      activateSearching = true;
      storeList = [];
      update();

      if(selectedFromDrawer) {
        storeList = await SearchAndFilterServices.searchForShop(searchController.text,selectingFilterTag);

         fillData();
      }else{
        storeList = await SearchAndFilterServices.searchForShopInMainCategory(mainCategoryId,searchController.text,selectingFilterTag);
         fillData();
      }


    }

  }
  Future<bool> checkStoreAddedOrNet(String storeId) async {
    FavoriteStatusModel? data= await  FavoriteServices.getShopIsInFavoriteOrNot(storeId);
    if(data?.status == 1){
      return true;
    }else{
      return false;
    }
  }
  addingOrRemovingStoreToFavorite(context,String storeId,int index) async {
    await checkStoreAddedOrNet(storeId);
    if(Get.find<StorageService>().checkUserIsSignedIn){
      if(  await checkStoreAddedOrNet(storeId)){
        ResponseModel? data = await FavoriteServices.addOrRemoveShopFromFavorite(storeId,"0");
        if(data?.msg != "succeeded"){
          showDialog(context: context,
              builder: (context) {
                return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight:Get.height*0.4);
              }
          );
        }else{
          var checker =  await checkStoreAddedOrNet( "${storeList?[index].id}");
          storeListWidget[index]=StoreWidget(store:storeList?[index], addingOrRemovingForFav: (){addingOrRemovingStoreToFavorite(context,"${storeList?[index].id}",index);}, shopAreAddedOrNot: checker, mainCategoryId: mainCategoryId, mainCategoryImg: mainCategoryImg,);


          update();
        }


      }else{
        ResponseModel? data = await FavoriteServices.addOrRemoveShopFromFavorite(storeId,"1");
        if(data?.msg != "succeeded"){
          showDialog(context: context,
              builder: (context) {
                return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight: Get.height*0.4);
              }
          );
        }else{
          var checker =  await checkStoreAddedOrNet( "${storeList?[index].id}");
          storeListWidget[index]=StoreWidget(store:storeList?[index], addingOrRemovingForFav: (){addingOrRemovingStoreToFavorite(context,"${storeList?[index].id}",index);}, shopAreAddedOrNot: checker, mainCategoryId: mainCategoryId, mainCategoryImg: mainCategoryImg,);
          update();
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
  getStoreData(bool selectCategory) async{
  if(selectCategory){
  storeIsLoading=true;
  update();
  }
    if(selectedFromDrawer){
      storeList = await ShopServices.getAllShops(selectingFilterTag);
     await fillData();
    }else {
      storeList = await ShopServices.getShopsForMainCategory(mainCategoryId,selectingFilterTag);
     await fillData();
    }

  }
  getMainCategoryData() async {
    mainCategoryList = await CategoryServices.getHomeCategory();
    categoryIsLoading = false;
    update();
  }
  fillData() async {
    storeListWidget = [];
    for (int i = 0; i <= storeList!.length-1; i=i+1) {
              storeListWidget.add(
                  StoreWidget(store:storeList?[i], addingOrRemovingForFav: (){addingOrRemovingStoreToFavorite(context,"${storeList?[i].id}",i);}, shopAreAddedOrNot: storeList?[i].favorite==1, mainCategoryId: mainCategoryId, mainCategoryImg: mainCategoryImg,)
              );

        }
    storeIsLoading = false;
    update();

  }
  selectingAnotherSubCategory(int mainCategoryId) async {
    selectedMainCategoryId = mainCategoryId;
    storeIsLoading = true;
    update();
    categoryIsLoading = true;
    await getSubCategoryData();
    storeList = await ShopServices.getShopsForMainCategory(mainCategoryId,"${0}");
    await fillData();
    storeIsLoading = false;
    update();
  }

}