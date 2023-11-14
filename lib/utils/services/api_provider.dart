import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:provider_demo/generated/json/base/json_convert_content.dart';
import 'package:provider_demo/model/login/response_login_entity.dart';
import 'package:provider_demo/model/product/response_p_entity.dart';
import 'package:provider_demo/model/response/demo_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../model/product/response_prod.dart';

class ApiService {
  static final ApiService _apiProvider = ApiService._internal();

  factory ApiService() {
    return _apiProvider;
  }

  ApiService._internal();

  String menuUrl = "https://jsonplaceholder.typicode.com/posts";
  String loginUrl = "https://reqres.in/api/login";
  String baseUrl = "https://thedigitalgeography.com/demos/application/";

  Future<List<DemoResponse>?> fundCharitiesList() async {
    try {
      http.Response data = await http.get(Uri.parse(menuUrl));
      if (data.statusCode == 200) {
        List<DemoResponse> listRes = [];
        List res = jsonDecode(data.body);
        res.forEach((element) {
          listRes.add(DemoResponse.fromJson(element));
        });
        return listRes;
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponsePEntity?> productList() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      var token = prefs.getString('token');
      http.Response data = await http.get(Uri.parse(baseUrl + "api/products"),
          headers: {"Authorization": token.toString()});
      if (data.statusCode == 200) {
        debugPrint('movieTitle: ${data.body}');

        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }

  Future<ResponseLoginEntity?> loginApi(
      {required String email, required String pwd}) async {
    try {
      Map<String, String> body = Map();
      body['email'] = email;
      body['password'] = pwd;
      http.Response data =
          await http.post(Uri.parse(baseUrl + "api/login"), body: body);
      debugPrint('movieTitle: ${data.body}');

      if (data.statusCode == 200) {
        return JsonConvert.fromJsonAsT(jsonDecode(data.body));
        ;
      } else {
        return Future.error(data.statusCode);
      }
    } catch (error) {
      return Future.error(error);
    }
  }
}
