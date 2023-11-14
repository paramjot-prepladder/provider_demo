import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_demo/model/response/demo_response.dart';
import 'package:provider_demo/provider/menu_provider.dart';
import 'package:provider_demo/utils/color/app_colors.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  MenuProvider? provider;

  @override
  void initState() {
    super.initState();
    providerInit();
    //  WidgetsBinding.instance?.addPostFrameCallback(
    //       (_) => _provider?.fundsWithCategory(context: context));
  }

  providerInit() {
    provider = Provider.of<MenuProvider>(context, listen: false);
    // _provider?.fundsWithCategory(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MenuProvider(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.liteBlack,
            title: Text('Menu'),
          ),
          backgroundColor: AppColors.whiteText,
          body: Container(
            child: Consumer<MenuProvider>(
              builder: (context, menuProvider, _) {
                return FutureProvider(
                  create: (_) {
                    return menuProvider.menuApi(context: context);
                  },
                  lazy: false,
                  initialData: DemoResponse(),
                  child: menuProvider.demo != null
                      ? ListView.builder(
                          shrinkWrap: true,
                          itemCount: menuProvider.demo?.length ?? 0,
                          itemBuilder: (ctx, i) {
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 10),
                                  color: AppColors.iconGrey,
                                  height: 60,
                                  width: double.infinity,
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      '${menuProvider.demo?[i].title}',
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          color: AppColors.whiteText,
                                          fontSize: 20),
                                    ),
                                  ),
                                ),
                                Divider(
                                  height: 1,
                                  color: AppColors.greylight,
                                ),
                              ],
                            );
                          },
                        )
                      : Center(
                          child: CircularProgressIndicator(
                            color: AppColors.pinkText,
                          ),
                        ),
                );
              },
            ),
          ),
        ));
  }
}
