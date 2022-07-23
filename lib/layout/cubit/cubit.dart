import 'package:electro_market/layout/cubit/states.dart';
import 'package:electro_market/models/home_model.dart';
import 'package:electro_market/modules/categories/categories_screen.dart';
import 'package:electro_market/modules/favorites/favorites_screen.dart';
import 'package:electro_market/modules/products/products_screen.dart';
import 'package:electro_market/modules/settings/settings_screen.dart';
import 'package:electro_market/shared/components/constants.dart';
import 'package:electro_market/shared/netwok/end_points.dart';
import 'package:electro_market/shared/netwok/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> bottomScreens = [
    ProductsScreen(),
    Categoriescreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeBottom(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeModel? homeModel;

  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
      url: HOME,
      query: null,
      token: token,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);
      emit(ShopSuccessHomeState());
      print(homeModel);
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeState());
    });
  }
}
