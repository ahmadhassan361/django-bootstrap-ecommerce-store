import 'package:quantum_genius/models/stock_model.dart';

class ShoppingListModel {
  int? count;
  String? next;
  String? previous;
  List<StockModel>? results;
  ShoppingListModel({this.count, this.next, this.previous, this.results});

  ShoppingListModel.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <StockModel>[];
      json['results'].forEach((v) {
        results!.add(StockModel.fromJson(v));
      });
    }
  }


}

