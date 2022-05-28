import 'package:quantum_genius/models/stock_model.dart';
import 'package:quantum_genius/models/user_models.dart';

class SingleProductModel {
  StockModel? stock;
  List<Images>? images;
  List<ProductColors>? colors;
  List<ProductSizes>? sizes;
  List<Reviews>? reviews;
  List<StockModel>? similar;

  SingleProductModel(
      {this.stock,
        this.images,
        this.colors,
        this.sizes,
        this.reviews,
        this.similar});
  SingleProductModel.fromJson(Map<String, dynamic> json) {
    stock = json['stock'] != null ?  StockModel.fromJson(json['stock']) : null;
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add( Images.fromJson(v));
      });
    }

    if (json['colors'] != null) {
      colors = <ProductColors>[];
      json['colors'].forEach((v) {
        colors!.add( ProductColors.fromJson(v));
      });
    }

    if (json['sizes'] != null) {
      sizes = <ProductSizes>[];
      json['sizes'].forEach((v) {
        sizes!.add( ProductSizes.fromJson(v));
      });
    }

    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add( Reviews.fromJson(v));
      });
    }

    if (json['similar'] != null) {
      similar = <StockModel>[];
      json['similar'].forEach((v) {
        similar!.add( StockModel.fromJson(v));
      });
    }
  }
}




class Images {
  int? id;
  String? image;
  int? product;

  Images({this.id, this.image, this.product});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    product = json['product'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['product'] = this.product;
    return data;
  }
}

class ProductColors {
  int? id;
  String? title;
  Null? image;
  int? product;

  ProductColors({this.id, this.title, this.image, this.product});
  ProductColors.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    product = json['product'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['product'] = this.product;
    return data;
  }
}

class ProductSizes {
  int? id;
  String? size;
  int? product;

  ProductSizes({this.id, this.size, this.product});

  ProductSizes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    size = json['size'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['size'] = this.size;
    data['product'] = this.product;
    return data;
  }
}

class Reviews {
  int? id;
  Customer? customer;
  int? rating;
  String? review;
  String? date;
  int? product;

  Reviews(
      {this.id,
        this.customer,
        this.rating,
        this.review,
        this.date,
        this.product});

  Reviews.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    rating = json['rating'];
    review = json['review'];
    date = json['date'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['rating'] = this.rating;
    data['review'] = this.review;
    data['date'] = this.date;
    data['product'] = this.product;
    return data;
  }
}

