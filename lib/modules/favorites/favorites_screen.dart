import 'package:electro_market/layout/cubit/cubit.dart';
import 'package:electro_market/layout/cubit/states.dart';
import 'package:electro_market/models/favorites_model.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:electro_market/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return (state is ShopLoadingGetFavoritesState)
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemBuilder: (context, index) => buildListItem(
                    ShopCubit.get(context).favoritesModel?.data?.data?[index],
                    context),
                separatorBuilder: (context, index) => mySeparator(),
                itemCount:
                    ShopCubit.get(context).favoritesModel?.data?.data?.length ??
                        0,
              );
      },
    );
  }

  }
