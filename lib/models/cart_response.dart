import 'package:quantum_genius/models/stock_model.dart';

class CartResponse {
  String? message;
  bool? error;
  List<Items>? items;
  double? price;
  int? shippingCharges;

  CartResponse(
      {this.message, this.error, this.items, this.price, this.shippingCharges});

  CartResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    error = json['error'];
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(Items.fromJson(v));
      });
    }
    price = json['price'].toDouble();
    shippingCharges = json['shipping_charges'] ;
  }


}
class Items {
  int? id;
  StockModel? product;
  int? quantity;
  String? color;
  String? size;
  String? dateAdded;
  int? order;

  Items(
      {this.id,
        this.product,
        this.quantity,
        this.color,
        this.size,
        this.dateAdded,
        this.order});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    product =
    json['product'] != null ?  StockModel.fromJson(json['product']) : null;
    quantity = json['quantity'];
    color = json['color'];
    size = json['size'];
    dateAdded = json['date_added'];
    order = json['order'];
  }


}
