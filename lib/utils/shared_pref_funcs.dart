import 'dart:async';
import 'dart:convert';

import 'package:quantum_genius/models/user_models.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<bool> setSession(AuthModel authModel) async{
  SharedPreferences sharedUser = await SharedPreferences.getInstance();
  sharedUser.setString("auth", jsonEncode(authModel));
  return true;
}

Future<AuthModel> getSession() async{
  SharedPreferences sharedUser = await SharedPreferences.getInstance();
  final res = sharedUser.getString("auth");
  return AuthModel.fromJson(jsonDecode(res!));
}

Future<bool> setLogin() async{
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.setBool("login", true);
  return true;
}

Future<bool> isLogin() async{
  SharedPreferences shared = await SharedPreferences.getInstance();
  bool result =shared.containsKey("login");
  return result;
}

Future<bool> logout() async{
  SharedPreferences shared = await SharedPreferences.getInstance();
  shared.clear();
  return true;
}
