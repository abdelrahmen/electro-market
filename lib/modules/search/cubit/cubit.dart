import 'package:electro_market/models/search_model.dart';
import 'package:electro_market/modules/search/cubit/states.dart';
import 'package:electro_market/shared/components/constants.dart';
import 'package:electro_market/shared/netwok/end_points.dart';
import 'package:electro_market/shared/netwok/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchsModel? model;

  void search(String text) {
    emit(SearchLoadingState());
    DioHelper.postData(
      token: token,
      url: SEARCH,
      data: {
        'text': text,
      },
    ).then((value) {
      model = SearchsModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(SearchErrorState());
    });
  }
}
