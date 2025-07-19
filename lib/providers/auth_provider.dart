import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../res/api_constants.dart';
import '../res/app_constants.dart';
import '../services/api_service.dart';

class AuthProvider extends ChangeNotifier{
  final _apiService = ApiService();

  bool _isLogging = false;
  bool get isLogging  => _isLogging;

  Future<bool> onLoginTap({required String email, required String password}) async {
    bool result = false;
    _isLogging = true;
    notifyListeners();

    final data = {
      'username' : email,
      'password' : password
    };
    try{
      final response =  await _apiService.postRequest(endpoint: ApiConstants.loginEndPoint, data: data);
      debugPrint("Login api response: ${response.body}");
      final responseMap = jsonDecode(response.body);
      bool status = responseMap['status'] ?? false;

      if(status){
        final Map<String,dynamic> map = jsonDecode(response.body)['data']['token']!;
        String role = map['role'];
        bool isGuard = role =='visitors';
        if(isGuard){
          result = true;
          String token = map['token'];
          String userID = map['userId'];
          String userName = map['name'];

          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString("token", token);
          await sharedPreferences.setString("userID", userID);
          await sharedPreferences.setString("userName", userName);
          await sharedPreferences.setBool("isLoggedIn", true);
        }else{
          Fluttertoast.showToast(msg: "Invalid Guard Credentials");
        }
      }else{
        Fluttertoast.showToast(msg: "Invalid Login Credentials");
      }


    }catch(e){
      String errorMessage = e.toString();
      if(e is SocketException){
        errorMessage = AppConstants.noInternetMsg;
      }

      Fluttertoast.showToast(msg: errorMessage);
    }

    _isLogging = false;
    notifyListeners();
    return result;
  }
}