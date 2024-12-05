import 'package:untitled/Utils/api_service.dart';
import 'package:untitled/Utils/services.dart';
import 'package:untitled/models/category_model.dart';


class CategoryServices {
  static ApiService api = ApiService();
  static Future<List<CategoryModel>?> getHomeCategory() async {
    List<CategoryModel>? categoryList = [];
    var data = await api.request(Services.categoryEndPoint, "POST");
    if (data != null) {
      for (var category in data){
        categoryList.add(CategoryModel.fromJson(category));
      }
      return categoryList;
    }
    return null;
  }
  static Future<List<CategoryModel>?> getSupCategory(int categoryId) async {
    List<CategoryModel>? categoryList = [];
    var data = await api.request(Services.categoryEndPoint, "POST",queryParamters: {
      "ctgid":categoryId
    });
    if (data != null) {
      for (var category in data){
        categoryList.add(CategoryModel.fromJson(category));
      }
      return categoryList;
    }
    return null;
  }
}