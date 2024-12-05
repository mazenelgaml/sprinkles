// ignore_for_file: avoid_print, prefer_is_empty, unnecessary_brace_in_string_interps

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart' hide CarouselController;
import 'package:flutter/rendering.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:untitled/Utils/colors.dart';
import 'package:untitled/Utils/constant.dart';
import 'package:untitled/Utils/localization_services.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/Utils/translation_key.dart';
import 'package:untitled/models/advertisment_model.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/models/favorite_model.dart';
import 'package:untitled/models/main_category_data.dart';
import 'package:untitled/models/product_pagination_model.dart';
import 'package:untitled/models/products_model.dart';
import 'package:untitled/models/response_model.dart';
import 'package:untitled/services/advrtisment_services.dart';
import 'package:untitled/services/category_services.dart';
import 'package:untitled/services/favorite_services.dart';
import 'package:untitled/services/product_service.dart';
import 'package:untitled/services/seaarch_and_filters_services.dart';
import 'package:untitled/ui/login/login_screen.dart';
import 'package:untitled/ui/product_screen/widgets/product_widget.dart';
import 'package:untitled/ui/siginup/signup_screen.dart';
import 'package:untitled/widgets/yes_or_no_dialogue.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../widgets/alert_dialogue.dart';

class ProductController extends GetxController {
  FocusNode myFocusNode = FocusNode();

  bool productIsLoading = true;
  bool categoryIsLoading = true;
  bool advertisementsIsLoading = true;
  late MainCategoryTapModel? data;
  final int mainCategoryId;
   final BuildContext context;
   final bool selectingFromDrawer;
  final String mainCategoryImg;
  ProductController(this.mainCategoryId, this.context, this.selectingFromDrawer, this.mainCategoryImg);
  late TextEditingController searchController;
  bool hasBeenSelectedFromDrawer = false;
  List<String> governmentData = [removeFilterTitle.tr,priceFilterDescTitle.tr,priceFilterAscTitle.tr,mostSelling.tr,mostRating.tr,];
  ScrollController scrollController = ScrollController();
  int selectedSubCategoryId = 0;
  String selectingFilterTag = "0";
  String selectingFilterTagName = removeFilterValue.tr;
  late List<ProductsModel>? productList;
  late List<CategoryModel>? subCategoryList;
  late List<CategoryModel>? mainCategoryList;
  late List<AdvertisementModel>? advertList;
 bool activateSearching = false;
 int selectedMainCategoryId = 240;
  bool mainCategoryIsLoading = true;
  List<Widget> products = [];
  late ProductPaginationModel? pagenationData;
 final GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();
  bool isVisible = false;
  int pageNumber = 1;
  bool isLoadingMoreData = false;
  @override
  Future<void> onInit() async {
    super.onInit();
    hasBeenSelectedFromDrawer = selectingFromDrawer;
    searchController = TextEditingController();
    myFocusNode.addListener( () {
     update();
    });
    if(selectingFromDrawer){
      await getMainCategoryData();
    }else{
      await getSubCategoryData();
    }
    await  getAdvertisementsData();
    scrollController.addListener(() {
      if ((scrollController.position.pixels ) == (scrollController.position.maxScrollExtent)) {
        print(scrollController.position.pixels);
        print(scrollController.position.maxScrollExtent);
        getMoreData();
      }
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
  getMoreData() async {


    if(pagenationData!.totalPages! >= pageNumber ) {
      pageNumber++;
      isLoadingMoreData= true;
      update();
      if(activateSearching){
        if(selectingFromDrawer)
        {
          if(selectedMainCategoryId==240){
            pagenationData  = await SearchAndFilterServices.searchForProducts(searchController.text,selectingFilterTag,pageNumber);
            productList?.addAll(pagenationData?.items as Iterable<ProductsModel>);
          }
          else{
            pagenationData  = await SearchAndFilterServices.searchForProductsInBranchCategory(selectedMainCategoryId, selectedSubCategoryId,searchController.text,selectingFilterTag,pageNumber);
            productList?.addAll(pagenationData?.items as Iterable<ProductsModel>);
          }
          pagenationData  = await SearchAndFilterServices.searchForProductsInBranchCategory(selectedMainCategoryId, selectedSubCategoryId,searchController.text,selectingFilterTag,pageNumber);
          productList?.addAll(pagenationData?.items as Iterable<ProductsModel>);
        }else{
          pagenationData  = await SearchAndFilterServices.searchForProductsInBranchCategory(mainCategoryId, selectedSubCategoryId,searchController.text,selectingFilterTag,pageNumber);
          productList?.addAll(pagenationData?.items as Iterable<ProductsModel>);
        }
       await fillingData();
        isLoadingMoreData = false;
        update();
      }else{
        if(selectingFromDrawer) {
          if (selectedMainCategoryId == 240) {
            pagenationData =await ProductServices.getAllProductsPagenation(
                pageNumber,selectingFilterTag);
            productList?.addAll(pagenationData?.items as Iterable<ProductsModel>);

          } else {
            pagenationData =await ProductServices.getProductsPagenation(
                selectedMainCategoryId, selectedSubCategoryId, pageNumber,selectingFilterTag);
            productList?.addAll(pagenationData?.items as Iterable<ProductsModel>);
          }
        }else{
          pagenationData = await ProductServices.getProductsPagenation(
              mainCategoryId, selectedSubCategoryId, pageNumber,selectingFilterTag);
          productList?.addAll(pagenationData?.items as Iterable<ProductsModel>);
        }

        await fillingData();
        isLoadingMoreData = false;
        update();
      }
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

  getMainCategoryData() async {
    mainCategoryList = await CategoryServices.getHomeCategory();
    mainCategoryIsLoading = false;
    update();
  }
  changeFilterData(){
    selectingFilter(selectingFilterTagName,true);
    governmentData = [removeFilterTitle.tr,priceFilterDescTitle.tr,priceFilterAscTitle.tr,mostSelling.tr,mostRating.tr,];
    update();
  }
  selectingFilter(String filterName,bool changingLanguageOnly){
    pageNumber = 1;
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
      case "Remove sort order":{
        selectingFilterTag = "0";
        selectingFilterTagName = removeFilterValue.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
      case "Price from lowest to highest":{
        selectingFilterTag =Filters. price_asc.name ;
        selectingFilterTagName = priceFilterDescTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
      case "Price from highest to lowest":{
        selectingFilterTag =Filters.price_desc.name;
        selectingFilterTagName = priceFilterAscTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
      case "Most Rated":{
        selectingFilterTag = Filters.review_asc.name;
        selectingFilterTagName = mostRating.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
      case "mostSelling":{
        selectingFilterTag =  Filters.views_asc.name;
        selectingFilterTagName = mostSelling.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
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
            getProductData(true);
          }
        }
      }
      break;
      case"السعر من الأقل  إلى الأعلى":{
        selectingFilterTag =Filters. price_asc.name ;
        selectingFilterTagName = priceFilterDescTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
      case"السعر من الأعلى  إلى الأقل":{
        selectingFilterTag =Filters.price_desc.name;
        selectingFilterTagName = priceFilterAscTitle.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
      case"الأكثر تقيماً":{
        selectingFilterTag = Filters.review_asc.name;
        selectingFilterTagName = mostRating.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
      case"الأكثر مبيعًا":{
        selectingFilterTag = Filters.views_asc.name;
        selectingFilterTagName = mostSelling.tr;
        update();
        if(!changingLanguageOnly) {
          if (activateSearching) {
            searchingForKeyword();
          } else {
            getProductData(true);
          }
        }
      }
      break;
    }
  }
  String removeAllWhitespaces(String string) {
    return string.replaceAll(' ', '');
  }
  selectingCategoryFromMainCategory(int mainCategoryId){
    selectedMainCategoryId = mainCategoryId;
    getSubCategoryData();
    getAdvertisementsData();
  }
  searchingForKeyword() async {
    pageNumber=1;
    if(removeAllWhitespaces(searchController.text)==""){
      activateSearching = false;
      getProductData(true);
    }else{
      productIsLoading = true;
      activateSearching = true;
      update();
      if(selectingFromDrawer)
      {
        if(selectedMainCategoryId==240){
          pagenationData  = await SearchAndFilterServices.searchForProducts(searchController.text,selectingFilterTag,pageNumber);
          productList = pagenationData?.items;
        }else{
          pagenationData  = await SearchAndFilterServices.searchForProductsInBranchCategory(selectedMainCategoryId, selectedSubCategoryId,searchController.text,selectingFilterTag,pageNumber);
          productList = pagenationData?.items;
        }
        pagenationData  = await SearchAndFilterServices.searchForProductsInBranchCategory(selectedMainCategoryId, selectedSubCategoryId,searchController.text,selectingFilterTag,pageNumber);
        productList = pagenationData?.items;
      } else{
        pagenationData  = await SearchAndFilterServices.searchForProductsInBranchCategory(mainCategoryId, selectedSubCategoryId,searchController.text,selectingFilterTag,pageNumber);
        productList = pagenationData?.items;
      }

      if(productList?.length != 0){
        await fillingData();
      }
      productIsLoading = false;
      update();
    }

  }
  getProductData(bool changingTap) async {
    pageNumber = 1;
    if(changingTap) {
      productIsLoading = true;
      update();
    }
    if(selectingFromDrawer) {
      if (selectedMainCategoryId == 240) {
        pagenationData =await ProductServices.getAllProductsPagenation(
            pageNumber,selectingFilterTag);
        productList = pagenationData?.items;

      } else {
        pagenationData =await ProductServices.getProductsPagenation(
            selectedMainCategoryId, selectedSubCategoryId, pageNumber,selectingFilterTag);
        productList = pagenationData?.items;
      }
    }else{
      pagenationData = await ProductServices.getProductsPagenation(
          mainCategoryId, selectedSubCategoryId, pageNumber,selectingFilterTag);
      productList = pagenationData?.items;
    }
    if(productList?.length != 0){
     await fillingData();
    }

    print("the length of widget list iS ${products.length}");
    productIsLoading = false;
    update();
  }

  Future<bool> checkProductAddedOrNet(String productId) async {
    FavoriteStatusModel? data= await  FavoriteServices.getProductIsInFavoriteOrNot(productId);
    if(data?.status == 1){
      return true;
    }else{
      return false;
    }
  }
  addingOrRemovingProductToFavorite(context,String productId,int index,bool doubleProductOrNot,) async {
    int i = 0;
    if(index!=0){
      i = (index/2).round();
    }

    print(i);
    print(index);
    if(Get.find<StorageService>().checkUserIsSignedIn){
      if( await checkProductAddedOrNet(productId)){
        ResponseModel? data = await FavoriteServices.addOrRemoveProductFromFavorite(productId,"0");
        if(data?.msg != "succeeded"){
          showDialog(context: context,
              builder: (context) {
                return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight:Get.height*0.4);
              }
          );
        }
      if(doubleProductOrNot){
        var checker =  Get.find<StorageService>().checkUserIsSignedIn?await checkProductAddedOrNet("${productList?[index].id}"):false;
        var checker1 =Get.find<StorageService>().checkUserIsSignedIn?await checkProductAddedOrNet("${productList?[index+1].id}"):false;
        products[i]=Column(
          children: [
            Padding(
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
            ),
            advertList?.length !=0?(index%5==0&&index!=0||(productList!.length == index||productList!.length == index-1))?Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              child: Container(
                height: Get.height * 0.2,
                width: Get.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                        height: Get.height * 0.19,
                        aspectRatio: 2.0,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                        autoPlay: true),

                    items: advertList?.map(
                            (e) {
                          return InkWell(
                            onTap: () {
                              selectingAdvertisements(
                                  e.link ?? "", e.id ?? 0);
                            },
                            child: CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${Services.baseEndPoint}${e.img ??
                                  ""}",
                              imageBuilder: ((context, image) {
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                      width: Get.width,
                                      height: Get.height * 0.16,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: image,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                  ),
                                );
                              }),
                              placeholder: (context, image) {
                                return Container(

                                  width: Get.width,
                                  height: Get.height * 0.16,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFDFDDDF),
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                ).animate(onPlay: (controller) =>
                                    controller.repeat())
                                    .shimmer(duration: 1200.ms,
                                    color: kDarkPinkColor.withAlpha(10))
                                    .animate(); // this wraps the previous Animate in another Animate


                              },
                              errorWidget: (context, url, error) {
                                return SizedBox(
                                  width: Get.width,
                                  height: Get.height * 0.16,
                                  child: Image.asset(
                                    "assets/images/logo sprinkles.png",
                                    fit: BoxFit.contain,),
                                );
                              },
                            ),
                          );
                        }
                    ).toList(),
                  ),
                ),
              ),
            ):const SizedBox():const SizedBox()
          ],
        );

      }else{
        var checker = Get.find<StorageService>().checkUserIsSignedIn?await checkProductAddedOrNet("${productList?[index].id}"):false;
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
            Padding(
              padding:const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
              child: Container(
                height: Get.height*0.2,
                width:Get.width,
                color:Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CarouselSlider(
                    options:  CarouselOptions(
                        height: Get.height*0.19,
                        aspectRatio: 2.0,
                        enlargeCenterPage: false,
                        viewportFraction: 1,
                        autoPlay: true),

                    items: advertList!.map(
                            (e){
                          return InkWell(
                            onTap:(){
                              selectingAdvertisements(e.link??"",e.id??0);
                            },
                            child:CachedNetworkImage(
                              fit: BoxFit.cover,
                              imageUrl: "${Services.baseEndPoint}${e.img??""}",
                              imageBuilder: ((context, image){
                                return  ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Container(
                                      width:Get.width,
                                      height:Get.height*0.16,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: image,
                                          fit:  BoxFit.cover,
                                        ),
                                      )
                                  ),
                                );
                              }),
                              placeholder: (context, image){
                                return   Container(

                                  width:Get.width,
                                  height:Get.height*0.16,
                                  decoration:BoxDecoration(
                                    color:  const Color(0xFFDFDDDF),
                                    borderRadius: BorderRadius.circular(15),

                                  ),
                                ).animate(onPlay: (controller) => controller.repeat())
                                    .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                    .animate(); // this wraps the previous Animate in another Animate


                              },
                              errorWidget: (context, url, error){
                                return SizedBox(
                                  width:Get.width,
                                  height:Get.height*0.16,
                                  child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.contain,),
                                );
                              },
                            ),
                          );

                        }
                    ).toList(),
                  ),
                ),
              ),
            ),
          ],
        );

      }

      }else{
        ResponseModel? data = await FavoriteServices.addOrRemoveProductFromFavorite(productId,"1");
        if(data?.msg != "succeeded"){
          showDialog(context: context,
              builder: (context) {
                return AlertDialogue(alertTitle: errorKey.tr, alertText: Get.find<StorageService>().activeLocale == SupportedLocales.english?data?.msg??"":data?.msgAr??"",alertIcon: "assets/icons/warningIcon.png",containerHeight:Get.height*0.4);
              }
          );
        }else{
          if(doubleProductOrNot){
            var checker =await checkProductAddedOrNet("${productList?[index].id}");
            var checker1 =await checkProductAddedOrNet("${productList?[index+1].id}");
            products[i]=Column(
              children: [
                Padding(
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
                ),
                advertList?.length !=0?i%5==0&&i!=0||(productList!.length == i||productList!.length == i-1)?Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: Container(
                    height: Get.height * 0.2,
                    width: Get.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: Get.height * 0.19,
                            aspectRatio: 2.0,
                            enlargeCenterPage: false,
                            viewportFraction: 1,
                            autoPlay: true),

                        items: advertList?.map(
                                (e) {
                              return InkWell(
                                onTap: () {
                                  selectingAdvertisements(
                                      e.link ?? "", e.id ?? 0);
                                },
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "${Services.baseEndPoint}${e.img ??
                                      ""}",
                                  imageBuilder: ((context, image) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                          width: Get.width,
                                          height: Get.height * 0.16,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                      ),
                                    );
                                  }),
                                  placeholder: (context, image) {
                                    return Container(

                                      width: Get.width,
                                      height: Get.height * 0.16,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDFDDDF),
                                        borderRadius: BorderRadius.circular(15),

                                      ),
                                    ).animate(onPlay: (controller) =>
                                        controller.repeat())
                                        .shimmer(duration: 1200.ms,
                                        color: kDarkPinkColor.withAlpha(10))
                                        .animate(); // this wraps the previous Animate in another Animate


                                  },
                                  errorWidget: (context, url, error) {
                                    return SizedBox(
                                      width: Get.width,
                                      height: Get.height * 0.16,
                                      child: Image.asset(
                                        "assets/images/logo sprinkles.png",
                                        fit: BoxFit.contain,),
                                    );
                                  },
                                ),
                              );
                            }
                        ).toList(),
                      ),
                    ),
                  ),
                ):const SizedBox():const SizedBox()
              ],
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
                Padding(
                  padding:const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
                  child: Container(
                    height: Get.height*0.2,
                    width:Get.width,
                    color:Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider(
                        options:  CarouselOptions(
                            height: Get.height*0.19,
                            aspectRatio: 2.0,
                            enlargeCenterPage: false,
                            viewportFraction: 1,
                            autoPlay: true),

                        items: advertList!.map(
                                (e){
                              return InkWell(
                                onTap:(){
                                  selectingAdvertisements(e.link??"",e.id??0);
                                },
                                child:CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "${Services.baseEndPoint}${e.img??""}",
                                  imageBuilder: ((context, image){
                                    return  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                          width:Get.width,
                                          height:Get.height*0.16,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit:  BoxFit.cover,
                                            ),
                                          )
                                      ),
                                    );
                                  }),
                                  placeholder: (context, image){
                                    return   Container(

                                      width:Get.width,
                                      height:Get.height*0.16,
                                      decoration:BoxDecoration(
                                        color:  const Color(0xFFDFDDDF),
                                        borderRadius: BorderRadius.circular(15),

                                      ),
                                    ).animate(onPlay: (controller) => controller.repeat())
                                        .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                        .animate(); // this wraps the previous Animate in another Animate


                                  },
                                  errorWidget: (context, url, error){
                                    return SizedBox(
                                      width:Get.width,
                                      height:Get.height*0.16,
                                      child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.contain,),
                                    );
                                  },
                                ),
                              );

                            }
                        ).toList(),
                      ),
                    ),
                  ),
                ),
              ],
            );

          }
        }
      }
      update();
    }else {
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
          }, alertYesButtonIcon: 'assets/icons/signUpIconDrawer.png', alertNoButtonIcon: 'assets/icons/loginIcon.png', alertIcon: 'assets/icons/favoriteIcon.png',containerHeight:   Get.height <= 800? Get.height*0.6: Get.height*0.5);
        });
  }
  getSubCategoryData() async {
    if(selectedMainCategoryId!=240){
      subCategoryList = await CategoryServices.getSupCategory(selectedMainCategoryId);
      data = await ProductServices.getMainProductData("$selectedMainCategoryId");
      categoryIsLoading = false;
      update();
    }else{
      subCategoryList = await CategoryServices.getSupCategory(mainCategoryId);
      data = await ProductServices.getMainProductData("$mainCategoryId");
      categoryIsLoading = false;
      update();
    }

  }
  getAdvertisementsData() async {
    if(selectingFromDrawer){
      advertList = await AdvertisementServices.getAdvertisements(selectedMainCategoryId);
      await  getProductData(true);
      advertisementsIsLoading = false;
      update();
    }else{
      advertList = await AdvertisementServices.getAdvertisements(mainCategoryId);
      await  getProductData(true);
      advertisementsIsLoading = false;
      update();
    }

  }
  selectingAnotherSubCategory(int subCategoryId){
    selectedSubCategoryId = subCategoryId;
    getAdvertisementsData();
  }
  selectingAdvertisements(String link,int advertisementsId) async {
    await AdvertisementServices.advertisementsHasBeenViewed("$advertisementsId");
    final Uri url = Uri.parse(link);
    if (!await launchUrl(url,mode:LaunchMode.externalNonBrowserApplication)) {
    throw Exception('Could not launch $url');
    }
  }
  fillingData()  async {
    products = [];

      for (int i = 0; i <= productList!.length-1; i=i+2) {

        if(i<productList!.length-1){

          print("hi from fill data${i} hi 2product");

          products.add(
            Column(
              children: [
                Padding(
                  padding:const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
                  child: Row(
                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                    children:[
                 ProductWidget(product:productList?[i], productAreAddedOrNot: productList?[i].favorite == 1 , addingOrRemovingProductToFavorite: (){
                        addingOrRemovingProductToFavorite(context,"${productList?[i].id}",i,true,);
                      }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,),

                     ProductWidget(product:productList?[i+1], productAreAddedOrNot: productList?[i].favorite == 1 , addingOrRemovingProductToFavorite: (){
                        addingOrRemovingProductToFavorite(context,"${productList?[i+1].id}",i,true,);
                      }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
                    ]
                  ),
                ),
                advertList?.length !=0?i%5==0&&i!=0||(productList!.length == i||productList!.length == i-1)?Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                  child: Container(
                    height: Get.height * 0.2,
                    width: Get.width,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: Get.height * 0.19,
                            aspectRatio: 2.0,
                            enlargeCenterPage: false,
                            viewportFraction: 1,
                            autoPlay: true),

                        items: advertList?.map(
                                (e) {
                              return InkWell(
                                onTap: () {
                                  selectingAdvertisements(
                                      e.link ?? "", e.id ?? 0);
                                },
                                child: CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "${Services.baseEndPoint}${e.img ??
                                      ""}",
                                  imageBuilder: ((context, image) {
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                          width: Get.width,
                                          height: Get.height * 0.16,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                      ),
                                    );
                                  }),
                                  placeholder: (context, image) {
                                    return Container(

                                      width: Get.width,
                                      height: Get.height * 0.16,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFDFDDDF),
                                        borderRadius: BorderRadius.circular(15),

                                      ),
                                    ).animate(onPlay: (controller) =>
                                        controller.repeat())
                                        .shimmer(duration: 1200.ms,
                                        color: kDarkPinkColor.withAlpha(10))
                                        .animate(); // this wraps the previous Animate in another Animate


                                  },
                                  errorWidget: (context, url, error) {
                                    return SizedBox(
                                      width: Get.width,
                                      height: Get.height * 0.16,
                                      child: Image.asset(
                                        "assets/images/logo sprinkles.png",
                                        fit: BoxFit.contain,),
                                    );
                                  },
                                ),
                              );
                            }
                        ).toList(),
                      ),
                    ),
                  ),
                ):const SizedBox():const SizedBox()
              ],
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
                            addingOrRemovingProductToFavorite(context,"${productList?[i].id}",i,false,);
                          }, mainCategoryId: mainCategoryId,comingFromProductDetails: false, comingFromFavoriteList: false, comingFromProductList: true,branchCategoryId: selectedSubCategoryId, mainCategoryImg: mainCategoryImg,)
                        ),

                      ]
                  ),
                  advertList?.length !=0?Padding(
                    padding:const EdgeInsets.fromLTRB(5.0,10.0,5.0,10.0),
                    child: Container(
                      height: Get.height*0.2,
                      width:Get.width,
                      color:Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CarouselSlider(
                          options:  CarouselOptions(
                              height: Get.height*0.19,
                              aspectRatio: 2.0,
                              enlargeCenterPage: false,
                              viewportFraction: 1,
                              autoPlay: true),

                          items: advertList!.map(
                              (e){
                                return InkWell(
                                  onTap:(){
                                    selectingAdvertisements(e.link??"",e.id??0);
                                  },
                                child:CachedNetworkImage(
                                  fit: BoxFit.cover,
                                  imageUrl: "${Services.baseEndPoint}${e.img ??
                                      ""}",
                                  imageBuilder: ((context, image){
                                    return  ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: Container(
                                          width:Get.width,
                                          height:Get.height*0.16,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: image,
                                              fit:  BoxFit.cover,
                                            ),
                                          )
                                      ),
                                    );
                                  }),
                                  placeholder: (context, image){
                                    return   Container(

                                      width:Get.width,
                                      height:Get.height*0.16,
                                          decoration:BoxDecoration(
                                            color:  const Color(0xFFDFDDDF),
                                            borderRadius: BorderRadius.circular(15),

                                          ),
                                        ).animate(onPlay: (controller) => controller.repeat())
                                            .shimmer(duration: 1200.ms, color:  kDarkPinkColor.withAlpha(10))
                                            .animate(); // this wraps the previous Animate in another Animate


                                  },
                                  errorWidget: (context, url, error){
                                    return SizedBox(
                                      width:Get.width,
                                      height:Get.height*0.16,
                                      child: Image.asset("assets/images/logo sprinkles.png",fit: BoxFit.contain,),
                                    );
                                  },
                                ),
                                );

                              }
                          ).toList(),
                        ),
                      ),
                    ),
                  ):const SizedBox(),
                ],
              )
          );

        }

     
      }
    }
  }
