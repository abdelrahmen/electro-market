import 'package:electro_market/models/login_model.dart';
import 'package:electro_market/modules/login/cubit/states.dart';
import 'package:electro_market/shared/netwok/end_points.dart';
import 'package:electro_market/shared/netwok/remote/dio_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopLoginCubit extends Cubit<ShopLoginStates> {
  ShopLoginCubit() : super(ShopLoginInitialState());

  late ShopLoginModel loginModel;

  static ShopLoginCubit get(context) => BlocProvider.of(context);

  void userLogin({
    required String email,
    required String password,
  }) {
    emit(ShopLoginLoadingState());
    DioHelper.postData(
      url: LOGIN,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginSuccessState(loginModel));
    }).catchError((onError) {
      emit(ShopLoginErrorState(onError.toString()));
      print(onError.toString());
    });
  }

  IconData suffixIcon = Icons.visibility_outlined;
  bool hidden = true;
  void changePassVissibitlty() {
    hidden = !hidden;
    suffixIcon =
        hidden ? Icons.visibility_outlined :Icons.visibility_off_outlined ;
    emit(ShopChangePassVisibilityState());
  }
}
