import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:quantum_genius/utils/endpoints.dart';
import '../models/homemodels.dart';

class NetworkService{
  Future<HomeModel> getHomeAPI() async{
    final response = await http.get(Uri.parse("$BASE_URL$HOME_SCREEN_END_POINT"));
    if(response.statusCode == 200){
      final json = jsonDecode(response.body);
      final HomeModel homeData = HomeModel.fromJson(json);
      return homeData;
    }
    else {
      throw Exception("Error! Something Went Wrong..");
    }
  }

}