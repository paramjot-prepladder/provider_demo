import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider_demo/ui/home/home.dart';
import 'package:provider_demo/utils/services/api_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/product/response_p_entity.dart';

//view model
class LoginProvider extends ChangeNotifier {
  void loginApi(
      {required String email,
      required String pwd,
      required BuildContext context}) async {
    var result = await ApiService().loginApi(email: email, pwd: pwd);
    if (result?.status == true) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString(
          'token', '${result?.data.tokenType} ${result?.data.token}');
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else {
      print('Something went wrong');
    }
    notifyListeners();
  }

  Future<ResponsePEntity?> productApi({required BuildContext context}) async {
    return ApiService().productList();
  }
}
