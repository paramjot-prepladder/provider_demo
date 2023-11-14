import 'package:flutter/material.dart';
import 'package:provider_demo/model/response/demo_response.dart';
import 'package:provider_demo/utils/services/api_provider.dart';

class MenuProvider extends ChangeNotifier {
  
  List<DemoResponse>? demo;
  menuApi(
      {required BuildContext context}) async {
    demo = await ApiService().fundCharitiesList();
    notifyListeners();
  }
}
