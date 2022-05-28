import 'package:quantum_genius/models/stock_model.dart';

class SliderModel {
  int? id;
  String? title;
  String? subTitle;
  String? image;

  SliderModel({this.id, this.title, this.subTitle, this.image});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    image = json['image'];
  }
}
class MainCategoryHomeModel {
  int? id;
  String? title;
  String? image;
  String? shortDesc;

  MainCategoryHomeModel({this.id, this.title, this.image, this.shortDesc});

  MainCategoryHomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    shortDesc = json['short_desc'];
  }

}
class SubCategoryHomeModel {
  int? id;
  String? title;
  String? image;
  int? category;

  SubCategoryHomeModel({this.id, this.title, this.image, this.category});

  SubCategoryHomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['image'] = this.image;
    data['category'] = this.category;
    return data;
  }
}
class BrandHomeModel {
  int? id;
  String? title;
  String? image;
  String? link;

  BrandHomeModel({this.id, this.title, this.image, this.link});

  BrandHomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    image = json['image'];
    link = json['link'];
  }

}
class OfferHomeModel {
  int? id;
  String? title;
  String? subTitle;
  String? image;

  OfferHomeModel({this.id, this.title, this.subTitle, this.image});

  OfferHomeModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    image = json['image'];
  }

}
class HomeModel {
  List<SliderModel>? slider;
  List<MainCategoryHomeModel>? categories;
  List<SubCategoryHomeModel>? subcat;
  List<BrandHomeModel>? brand;
  List<OfferHomeModel>? offer;
  List<StockModel>? bestSellers;
  List<StockModel>? productList;

  HomeModel(
      {this.slider,
        this.categories,
        this.subcat,
        this.brand,
        this.offer,
        this.bestSellers});

  HomeModel.fromJson(Map<String, dynamic> json) {

    if (json['slider'] != null) {
      slider = [];
      json['slider'].forEach((v) {
        slider!.add( SliderModel.fromJson(v));

      });
    }

    if (json['categories'] != null) {
      categories = <MainCategoryHomeModel>[];
      json['categories'].forEach((v) {
        categories!.add(MainCategoryHomeModel.fromJson(v));
      });
    }

    if (json['subcat'] != null) {
      subcat = <SubCategoryHomeModel>[];
      json['subcat'].forEach((v) {
        subcat!.add(SubCategoryHomeModel.fromJson(v));
      });
    }

    if (json['brand'] != null) {
      brand = <BrandHomeModel>[];
      json['brand'].forEach((v) {
        brand!.add(BrandHomeModel.fromJson(v));
      });
    }

    if (json['offer'] != null) {
      offer = <OfferHomeModel>[];
      json['offer'].forEach((v) {
        offer!.add(OfferHomeModel.fromJson(v));
      });
    }

    if (json['best_sellers'] != null) {
      bestSellers = <StockModel>[];
      json['best_sellers'].forEach((v) {
        bestSellers!.add(StockModel.fromJson(v));
      });
    }

    if (json['products'] != null) {
      productList = <StockModel>[];
      json['products'].forEach((v) {
        productList!.add(StockModel.fromJson(v));
      });
    }
  }


}

