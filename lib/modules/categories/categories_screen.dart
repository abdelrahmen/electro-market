import 'package:electro_market/layout/cubit/cubit.dart';
import 'package:electro_market/layout/cubit/states.dart';
import 'package:electro_market/models/categories_model.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Categoriescreen extends StatelessWidget {
  const Categoriescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCategoryItem(
              ShopCubit.get(context).categoriesModel?.data?.data[index]),
          separatorBuilder: (context, index) => mySeparator(),
          itemCount:
              ShopCubit.get(context).categoriesModel?.data?.data.length ?? 0,
        );
      },
    );
  }

  Widget buildCategoryItem(DataModel? model) => Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage('${model?.image}'),
              width: 100,
              height: 100,
            ),
            Text(
              '${model?.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
      );
}
