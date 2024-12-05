import 'package:get/get.dart';
import 'package:untitled/Utils/api_service.dart';
import 'package:untitled/Utils/memory.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/models/order_history_model.dart';

class OrderHistoryServices{
  static ApiService api = ApiService();
  Future<List<OrderHistoryModel>?> getOrdersHistory(String status) async {
    List<OrderHistoryModel>? ordersHistoryList = [];
    var data = await api.request(Services.getOrdersHistoryEndPoint, "POST",queryParamters: {
      "member_id": Get.find<StorageService>().getId,
      "status":status,
    });
    if (data != null) {
      for (var order in data){
        ordersHistoryList.add(OrderHistoryModel.fromJson(order));
      }
      return ordersHistoryList;
    }
    return null;
  }
}