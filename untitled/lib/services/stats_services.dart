import 'package:get/get.dart';
import 'package:untitled/Utils/api_service.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/models/response_model.dart';

class StatsServices{
  static ApiService api = ApiService();
  Future<ResponseModel?> sendingOrderNowOrWhatsAppOrCallHasBeenClicked(String shopId,String itemId,String orderType,String msg) async {
    var data = await api.request(Services.statsEndPoint, "POST",queryParamters: {
      "member_id": Get.find<StorageService>().getId,
      "shop_id":shopId,
      "item_id":itemId,
      "order_type":orderType,
      "msg":msg,
    });
    if (data != null) {
      return ResponseModel.fromJson(data);
    }
    return null;
  }
}