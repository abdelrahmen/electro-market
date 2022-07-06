import 'package:electro_market/models/login_model.dart';

abstract class ShopLoginStates{}

class ShopLoginInitialState extends ShopLoginStates {}

class ShopLoginLoadingState extends ShopLoginStates {}

class ShopLoginSuccessState extends ShopLoginStates {
  final ShopLoginModel loginModel;

  ShopLoginSuccessState(this.loginModel);
}

class ShopLoginErrorState extends ShopLoginStates {
  //34an azhero 3ala el screen
  final String error;

  ShopLoginErrorState(this.error);
}

class ShopChangePassVisibilityState extends ShopLoginStates{}