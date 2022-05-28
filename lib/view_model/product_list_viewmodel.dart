// import 'package:quantum_genius/models/homemodels.dart';
// import 'package:quantum_genius/models/stock_model.dart';
// import 'package:quantum_genius/services/network_service.dart';
//
// class ProductListViewModel{
//   List<StockViewModel>? stockViewModel;
//   Future<void>  getProductList() async{
//     final apiResult = await NetworkService().getProductList();
//
//     stockViewModel = apiResult.map((e)=>StockViewModel(e)).toList();
//   }
// }
// class StockViewModel{
//   late  StockModel stockModel;
//   StockViewModel(this.stockModel);
// }