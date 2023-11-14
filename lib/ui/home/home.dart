import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/provider/home_provider.dart';
import 'package:provider_demo/ui/cart/cart.dart';
import 'package:provider_demo/ui/menu/menu.dart';
import 'package:provider_demo/utils/color/app_colors.dart';
import 'package:provider_demo/utils/common/common_widgets.dart';
import 'package:provider_demo/utils/common/text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../provider/login_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _nameCtrl;

  @override
  void initState() {
    super.initState();
    initPref();
    // var loginProvider = Provider.of<LoginProvider>(context);
    //
    // var a =  loginProvider.productApi(context: context);
    // debugPrint('tag: ${a}');

    _nameCtrl = TextEditingController();
  }

  initPref() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('nativeData', 'testing android in flutter');
    var value = prefs.getString('nativeData');
    print(value);
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => LoginProvider(),
        child: Scaffold(
          backgroundColor: AppColors.whiteText,
          appBar: AppBar(
            title: Text('Provider Demo'),
            backgroundColor: AppColors.greylight,
            actions: [
              IconButton(
                color: AppColors.whiteText,
                icon: Icon(Icons.shopping_cart_outlined),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Cart()),
                  );
                },
              ),
            ],
            leading: IconButton(
              color: AppColors.whiteText,
              icon: Icon(Icons.notification_important),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MenuScreen()),
                );
              },
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Consumer<LoginProvider>(builder: (context, loginProvider, _) {
                return Text(context
                    .watch<LoginProvider>()
                    .productApi(context: context)
                    .toString());
              }),
              CommonTextField(
                controller: _nameCtrl,
              ),
              sizedBox(context: context, hei: 0.03),
              button(
                text: 'Add Item',
                onTap: () {
                  onTapBtn();
                },
              ),
            ],
          ),
        ));
  }

  void onTapBtn() async {
    if (_nameCtrl.text.isEmpty) return;
    await Provider.of<HomeProvider>(context, listen: false)
        .addItem(_nameCtrl.text);
    _nameCtrl.clear();
  }
}
