import 'package:electro_market/modules/login/shop_login_screen.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:electro_market/shared/netwok/local/cache_helper.dart';
import 'package:electro_market/shared/netwok/remote/dio_helper.dart';

String? token = '';

void signOut(context) {
  CacheHelper.removeData(
    key: 'token',
  ).then((value) {
    if (value) {
      navigateWithNoBack(
        context,
        ShopLoginScreen(),
      );
    }
  }).catchError((onError) {});
}
