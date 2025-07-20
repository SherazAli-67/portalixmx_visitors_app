import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:portalixmx_visitor_app/models/user_api_response_model.dart';
import 'package:portalixmx_visitor_app/res/api_constants.dart';
import 'package:portalixmx_visitor_app/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeProvider extends ChangeNotifier{
  final apiService = ApiService();
  final String _userKey = 'user';
  bool _loadingProfile = false;
  UserModel? _user;
  
  UserModel? get user => _user;
  bool get loadingProfile => _loadingProfile;

  HomeProvider(){
    _initUser();
  }

  void _initUser() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final userMap = sharedPreferences.getString(_userKey);
    if(userMap != null){
      _user = UserModel.fromJson(jsonDecode(userMap));
      debugPrint("SharedPreferences response: ${_user!.name}");
      _loadingProfile = false;
      notifyListeners();
      return;
    }
    _loadingProfile = true;
    notifyListeners();
    final response = await apiService.getRequest(endpoint: ApiConstants.userProfile);
    debugPrint("Api response: ${response?.body}");
    if(response != null){
      UserApiResponse userApiResponse = UserApiResponse.fromJson(jsonDecode(response.body));
      _user = userApiResponse.data;
      _loadingProfile = false;
      notifyListeners();
      sharedPreferences.setString(_userKey, jsonEncode(_user!.toJson()));
    }
  }


  void updateUser(UserModel user)async{
    /*_user!.copyWith(
      name: updateMap['name'],
      mobile: updateMap['mobile'],
        additionalDetails:
        AdditionalDetails(vehicleName: updateMap['additionalDetails']['vehicleName'],
            color: updateMap['additionalDetails']['color'],
            licensePlate: updateMap['additionalDetails']['licensePlate'],
            registrationNumber: updateMap['additionalDetails']['registrationNumber'],
        ),
      emergencyContacts: updateMap['emergencyContacts']
    );
    notifyListeners();*/

    _user = user;
    notifyListeners();

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString(_userKey, jsonEncode(_user!.toJson()));
  }
}