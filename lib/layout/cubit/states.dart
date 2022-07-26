import 'package:electro_market/models/change_favorites_model.dart';
import 'package:electro_market/models/login_model.dart';

abstract class ShopStates{}

class ShopInitialState extends ShopStates{}

class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeState extends ShopStates{}

class ShopSuccessHomeState extends ShopStates{}

class ShopErrorHomeState extends ShopStates{}

class ShopSuccessCategoriesState extends ShopStates{}

class ShopErrorCategoriesState extends ShopStates{}

class ShopChangeFavoriteState extends ShopStates{}

class ShopSuccessChangeFavoriteState extends ShopStates{
  final ChangeFavoritesModel? model;

  ShopSuccessChangeFavoriteState(this.model);
}

class ShopErrorChangeFavoriteState extends ShopStates{}

class ShopLoadingGetFavoritesState extends ShopStates{}

class ShopSuccessGetFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesState extends ShopStates{}

class ShopLoadingUserDataState extends ShopStates{}

class ShopSuccessUserDataState extends ShopStates{
  final ShopLoginModel? loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopErrorUserDataState extends ShopStates{}

class ShopLoadingUpdateUserDataState extends ShopStates{}

class ShopSuccessUpdateUserDataState extends ShopStates{
  final ShopLoginModel? loginModel;

  ShopSuccessUpdateUserDataState(this.loginModel);
}

class ShopErrorUpdateUserDataState extends ShopStates{}