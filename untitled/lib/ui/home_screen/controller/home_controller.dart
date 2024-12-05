import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled/models/category_model.dart';
import 'package:untitled/services/category_services.dart';

class HomeController extends GetxController {
  bool isLoading = true;
 late List<CategoryModel>? dataHomeCategory;
  GlobalKey<ScaffoldState> scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Future<void> onInit() async {
    super.onInit();
    getData();
  }
getData() async {
  dataHomeCategory = await CategoryServices.getHomeCategory();
  isLoading = false;
  update();
}
}