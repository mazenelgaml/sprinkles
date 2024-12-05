
import 'package:get/get.dart';
import 'package:untitled/ui/product_detailed_screen/controller/product_detailed_controller.dart';
import 'package:untitled/ui/product_detailed_screen/product_detailed_screen.dart';
import 'package:untitled/ui/store_details_screen/controller/store_detailed_screen.dart';
import 'package:untitled/ui/store_details_screen/store_details_screen.dart';


class DynamicLinkHandler {

  Future<void> initDynamicLinks() async {

;
    initUniLinks();
  }
  Future<void> initUniLinks() async {

  }
  void handleDeepLink(String path) {

    var pos = path.lastIndexOf('_');
    String result = (pos != -1)? path.substring(0, pos): path;
    print(result.contains("s"));
    var aStr = result.replaceAll(new RegExp(r'[^0-9]'),''); // '23'
    var aInt = int.parse(aStr);
    print(aInt);
    bool test4 = Get.isRegistered<ProductDetailedController>();
    if(test4){
      Get.delete<ProductDetailedController>();
    }
    bool test3 = Get.isRegistered<StoreDetailedController>();
    if(test3){
      Get.delete<StoreDetailedController>();
    }
    if(result.contains("s")){
      Get.to(()=>StoreDetailedScreen(shopId: "${aInt}", mainCategoryId: 1, mainCategoryImg: '',),preventDuplicates: false);

    }else{
      Get.to(()=>ProductDetailedScreen(productId: "${aInt}", mainCategoryId: 1, comingFromProductList: false, comingFromFavoriteList: false, comingFromProductDetails: false, branchCategoryId: 2, mainCategoryImg: ""),preventDuplicates: false);

    }
  }
}
