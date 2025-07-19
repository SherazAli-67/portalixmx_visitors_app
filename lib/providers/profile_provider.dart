import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/login_page.dart';
import '../models/user_api_response_model.dart';
import '../res/api_constants.dart';
import '../res/app_constants.dart';
import '../services/api_service.dart';

class ProfileProvider extends ChangeNotifier{
  final _apiService = ApiService();
  bool _loadingProfile = false;
  bool _updatingProfile = false;
  // final _emergencyContactKey = 'emergencyContacts';

  UserModel? _user;
  // final List<EmergencyContact> _emergencyContacts = [];

  bool get loadingProfile => _loadingProfile;
  bool get updatingProfile => _updatingProfile;
  UserModel? get user => _user;
  // List<EmergencyContact> get emergencyContacts =>  _emergencyContacts;

  ProfileProvider(){
    _initProfile();
  }

  _initProfile()async{
    _loadingProfile = true;
    notifyListeners();
    final response = await _apiService.getRequest(endpoint: ApiConstants.userProfile, );
    debugPrint("User api response: ${response?.body}");
    if(response != null){
      if(response.statusCode == 200){
        UserApiResponse userApiResponse = UserApiResponse.fromJson(jsonDecode(response.body));
        _user = userApiResponse.data;
      }
      _loadingProfile = false;
      notifyListeners();
    }

    // _initEmergencyContactList();
  }

  Future<bool> updateUserProfile({required Map<String, dynamic> data})async {

    bool result = false;
    _updatingProfile = true;
    notifyListeners();
    try{
      result = await _apiService.updateProfile(map: data);
      // final response = await _apiService.postRequestWithToken(endpoint: ApiConstants.updateProfile, data: data,);
    }catch(e){
      String errorMessage = e.toString();
      if(e is PlatformException){
        errorMessage = e.message!;
      }else if(e is SocketException){
        errorMessage = AppConstants.noInternetMsg;
      }
      Fluttertoast.showToast(msg: errorMessage);
      debugPrint("Error while updating profile: $errorMessage");
    }

    _updatingProfile = false;
    notifyListeners();
    return result;
  }

  void onLogoutTap(BuildContext context)async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_)=> LoginPage()), (val)=> false);
  }

  /*Future<bool> _initEmergencyContactList() async{
    bool result = false;
    try{
      final response = await _apiService.getRequest(endpoint: ApiConstants.emergencyContactList);
      debugPrint("EmergencyContacts response: ${response?.body}");
      if(response != null){
        result = response.statusCode == 200;
        EmergencyContactApiResponse userApiResponse = EmergencyContactApiResponse.fromJson(jsonDecode(response.body));
        _emergencyContacts.addAll(userApiResponse.data);
        notifyListeners();
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        List<Map<String,dynamic>> map = _emergencyContacts.map((contact)=> contact.toJson()).toList();
        sharedPreferences.setString(_emergencyContactKey, jsonEncode(map));
      }
    }catch(e){
      String errorMessage = e.toString();
      if(e is PlatformException){
        errorMessage = e.message!;
      }else if(e is SocketException){
        errorMessage = AppConstants.noInternetMsg;
      }
      Fluttertoast.showToast(msg: errorMessage);
      debugPrint("Error while getting emergencyContacts: $errorMessage");
    }

    _updatingProfile = false;
    notifyListeners();
    return result;
  }*/
}