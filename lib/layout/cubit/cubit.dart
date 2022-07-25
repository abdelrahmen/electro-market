import 'dart:async';
import 'dart:ffi';

import 'package:electro_market/layout/cubit/states.dart';
import 'package:electro_market/models/categories_model.dart';
import 'package:electro_market/models/change_favorites_model.dart';
import 'package:electro_market/models/favorites_model.dart';
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

  Map<int?, bool?> favorites = {};

  void getHomeData() {
    emit(ShopLoadingHomeState());
    DioHelper.getData(
      url: HOME,
      query: null,
      token: token,
    ).then((value) {
      print(token);
      homeModel = HomeModel.fromJson(value.data);
      homeModel?.data.products.forEach((element) {
        favorites.addAll({
          element.id: element.inFavorites,
        });
      });
      emit(ShopSuccessHomeState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorHomeState());
    });
  }

  CategoriesModel? categoriesModel;

  void getCategories() {
    DioHelper.getData(
      url: GET_CATEGORIES,
      query: null,
      token: token,
    ).then((value) {
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorCategoriesState());
    });
  }

  ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? id) {
    favorites[id] = !(favorites[id] ?? false);
    emit(ShopChangeFavoriteState());
    DioHelper.postData(
      url: FAVORITES,
      data: {'product_id': id},
      token: token,
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      emit(ShopSuccessChangeFavoriteState(changeFavoritesModel));
      if (!(changeFavoritesModel?.status ?? false)) {
        favorites[id] = !(favorites[id] ?? false);
      } else {
        getFavorites();
      }
    }).catchError((onError) {
      favorites[id] = !(favorites[id] ?? true);
      emit(ShopErrorChangeFavoriteState());
    });
  }

  FavoritesModel? favoritesModel;

  void getFavorites() {
    emit(ShopLoadingGetFavoritesState());
    DioHelper.getData(
      url: FAVORITES,
      query: null,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      emit(ShopSuccessGetFavoritesState());
    }).catchError((onError) {
      print(onError.toString());
      emit(ShopErrorGetFavoritesState());
    });
  }
}
