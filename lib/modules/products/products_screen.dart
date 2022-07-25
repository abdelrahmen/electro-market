import 'dart:ui';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:electro_market/layout/cubit/cubit.dart';
import 'package:electro_market/layout/cubit/states.dart';
import 'package:electro_market/models/categories_model.dart';
import 'package:electro_market/models/home_model.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:electro_market/shared/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoriteState) {
          if (!(state.model?.status??true)) {
            flutterToast(msg: '${state.model?.message}');
          }
        }
      },
      builder: (context, state) {
        return (ShopCubit.get(context).homeModel != null &&
                ShopCubit.get(context).categoriesModel != null)
            ? homeBuilder(ShopCubit.get(context).homeModel,
                ShopCubit.get(context).categoriesModel, context)
            : const Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget homeBuilder(
          HomeModel? model, CategoriesModel? categoriesModel, context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: model?.data.banners
                  .map((e) => Image(
                        image: NetworkImage('${e.image}'),
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ))
                  .toList(),
              options: CarouselOptions(
                height: 200,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            // categories text, list & new products text
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // categories list view,
                  Container(
                    height: 100,
                    child: ListView.separated(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) =>
                          buildCategoryItem(categoriesModel?.data?.data[index]),
                      separatorBuilder: (context, index) => SizedBox(width: 5),
                      itemCount: categoriesModel?.data?.data.length ?? 0,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  //new products text
                  Text(
                    'New Products',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1,
              crossAxisSpacing: 1,
              childAspectRatio: 1 / 1.59,
              children: List.generate(
                  model?.data.products.length ?? 0,
                  (index) =>
                      buildGridProduct(model?.data.products[index], context)),
            ),
          ],
        ),
      );

  Widget buildCategoryItem(DataModel? dataModel) => Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Image(
            image: NetworkImage('${dataModel?.image}'),
            width: 100,
            height: 100,
            fit: BoxFit.cover,
          ),
          //category text in container
          Container(
            width: 100,
            color: Colors.black.withOpacity(0.8),
            child: Text(
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              '${dataModel?.name}',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      );

  Widget buildGridProduct(ProductModel? model, context) => Container(
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage('${model?.image}'),
                  width: double.infinity,
                  height: 200,
                ),
                if (model?.discount != 0)
                  Container(
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'DISCOUNT',
                      style: TextStyle(
                        fontSize: 8,
                        color: Colors.white,
                      ),
                    ),
                  )
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //product name
                  Text(
                    '${model?.name}\n',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Row(
                    children: [
                      //price text
                      Text(
                        '${model?.price.round()}',
                        style: TextStyle(
                          color: defaultColor,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      //old price text
                      if (model?.discount != 0)
                        Text(
                          '${model?.oldPrice.round()}',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 10,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      Spacer(),
                      IconButton(
                        onPressed: () {
                          ShopCubit.get(context).changeFavorites(model?.id);
                          print(model?.id);
                        },
                        icon: Icon(
                          Icons.favorite,
                          color: ShopCubit.get(context).favorites[model?.id] ?? false
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
      );
}
