import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../res/api_constants.dart';

class ApiService {

  Future<http.Response> postRequest({required String endpoint, required Map<String, dynamic> data}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    //return {'Content-Type': 'application/json', 'Cookie' : cookies};
    Map<String, String> headers = {'Content-Type': 'application/json',};
    final response = await http.post(
      url,
      headers: headers,
      // headers: {'Content-Type': 'application/json', 'X-Bypass-Auth-Key' : ApiConstants.universalToken},
      body: jsonEncode(data),
    );


    debugPrint("Post request response: ${response.body}");
    return response;
  }


  Future<http.Response> deleteRequest({required String endpoint,}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Delete Url: $url");

    Map<String, String> headers = {'Content-Type': 'application/json',};
    final response = await http.delete(url, headers: headers);

    debugPrint("$endpoint Api response: ${response.statusCode}");
    return response;
  }

  Future<http.Response> getRequest({required String endpoint,}) async {
    var url = Uri.parse(ApiConstants.baseUrl + endpoint);
    debugPrint("Get URL: $url");

    Map<String, String> headers = {'Content-Type': 'application/json',};
    final response = await http.get(
      url,
      headers: headers,
    );
    debugPrint("$endpoint Api response: ${response.statusCode}");
    return response;
  }
}