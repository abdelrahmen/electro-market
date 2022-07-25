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
                itemBuilder: (context, index) => buildFavoriteItem(
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

  Widget buildFavoriteItem(FavoritesData? model, context) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          height: 120,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  //product image
                  Image(
                    image: NetworkImage('${model?.product?.image}'),
                    width: 120,
                    height: 120,
                  ),
                  //discount text
                  if (model?.product?.discount != 0)
                    Container(
                      color: Colors.red,
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const Text(
                        'DISCOUNT',
                        style: TextStyle(
                          fontSize: 8,
                          color: Colors.white,
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //product name
                    Text(
                      '${model?.product?.name}\n',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        //price text
                        Text(
                          '${model?.product?.price}',
                          style: const TextStyle(
                            color: defaultColor,
                          ),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        //old price text
                        if (model?.product?.discount != 0)
                          Text(
                            '${model?.product?.oldPrice}',
                            style: const TextStyle(
                              color: Colors.grey,
                              fontSize: 10,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const Spacer(),
                        //add or remove from favorites
                        IconButton(
                          onPressed: () {
                            ShopCubit.get(context)
                                .changeFavorites(model?.product?.id);
                          },
                          icon: Icon(
                            Icons.favorite,
                            color: ShopCubit.get(context)
                                        .favorites[model?.product?.id] ??
                                    false
                                ? Colors.blue
                                : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
