import 'package:quantum_genius/models/homemodels.dart';

class StockModel {
  int? id;
  Product? product;
  int? quantity;
  int? purchasePrice;
  int? salePrice;
  int? discount;
  bool? enabled;

  StockModel(
      {this.id,
        this.product,
        this.quantity,
        this.purchasePrice,
        this.salePrice,
        this.discount,
        this.enabled});

  StockModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
    quantity = json['quantity'];
    purchasePrice = json['purchase_price'];
    salePrice = json['sale_price'];
    discount = json['discount'];
    enabled = json['enabled'];
  }


}

class Product {
  int? id;
  String? title;
  String? shortDesc;
  String? description;
  bool? newArrival;
  String? image;
  String? youtubeVideoUrl;
  String? date;
  int? category;
  BrandHomeModel? brand;

  Product(
      {this.id,
        this.title,
        this.shortDesc,
        this.description,
        this.newArrival,
        this.image,
        this.youtubeVideoUrl,
        this.date,
        this.category,
        this.brand});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    shortDesc = json['short_desc'];
    description = json['description'];
    newArrival = json['new_arrival'];
    image = json['image'];
    youtubeVideoUrl = json['youtube_video_url'];
    date = json['date'];
    category = json['category'];
    brand = BrandHomeModel.fromJson(json['brand']);
  }


}