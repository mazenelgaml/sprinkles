// To parse this JSON data, do
//
//     final shopDetailedModel = shopDetailedModelFromJson(jsonString);

import 'dart:convert';

import 'package:untitled/models/branch_model.dart';
import 'package:untitled/models/category_model.dart';

ShopDetailedModel shopDetailedModelFromJson(String str) => ShopDetailedModel.fromJson(json.decode(str));

String shopDetailedModelToJson(ShopDetailedModel data) => json.encode(data.toJson());

class ShopDetailedModel {
  int? id;
  String? name;
  String? nameEn;
  int? visitors;
  String? locationLon;
  String? locationLat;
  String? address;
  String? addressEn;
  String? phone;
  String? whatsapp;
  String? desc;
  String? descEn;
  int? star;
  List<CategoryModel>? ctgs;
  String? image;
  int? favorite;
  String? link;
  List<Branch>? branch;

  ShopDetailedModel({
    this.id,
    this.name,
    this.nameEn,
    this.visitors,
    this.locationLon,
    this.locationLat,
    this.address,
    this.addressEn,
    this.phone,
    this.whatsapp,
    this.desc,
    this.descEn,
    this.star,
    this.ctgs,
    this.image,
    this.favorite,
    this.link,

    this.branch,
  });

  factory ShopDetailedModel.fromJson(Map<String, dynamic> json) => ShopDetailedModel(
    id: json["id"],
    name: json["name"],
    nameEn: json["name_en"],
    visitors: json["visitors"],
    locationLon: json["location_lon"],
    locationLat: json["location_lat"],
    address: json["address"],
    addressEn: json["address_en"],
    phone: json["phone"],
    whatsapp: json["whatsapp"],
    desc: json["desc"],
    descEn: json["desc_en"],
    star: json["star"],
    ctgs: json["ctgs"] == null ? [] : List<CategoryModel>.from(json["ctgs"]!.map((x) => CategoryModel.fromJson(x))),
    image: json["image"],
    favorite: json["favorite"],
    link: json["link"],
    branch: json["branch"] == null ? [] : List<Branch>.from(json["branch"]!.map((x) => Branch.fromJson(x))),


  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "name_en": nameEn,
    "visitors": visitors,
    "location_lon": locationLon,
    "location_lat": locationLat,
    "address": address,
    "address_en": addressEn,
    "phone": phone,
    "whatsapp": whatsapp,
    "desc": desc,
    "desc_en": descEn,
    "star": star,
    "ctgs": ctgs == null ? [] : List<dynamic>.from(ctgs!.map((x) => x.toJson())),
    "image": image,
    "favorite": favorite,
    "branch": branch == null ? [] : List<dynamic>.from(branch!.map((x) => x.toJson())),
    "link": link,

  };
}







