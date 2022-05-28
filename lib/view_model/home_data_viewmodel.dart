import 'package:quantum_genius/models/homemodels.dart';
import 'package:quantum_genius/services/network_service.dart';

class HomeDataViewModel{
   HomeModel? homeModel;
  Future<void>  getHomeData() async{
    final apiResult = await NetworkService().getHomeAPI();
    homeModel = apiResult;
  }
}
