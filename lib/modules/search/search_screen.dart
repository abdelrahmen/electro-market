import 'package:electro_market/modules/search/cubit/cubit.dart';
import 'package:electro_market/modules/search/cubit/states.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    var searchController = TextEditingController();

    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Form(
            key: formKey,
            child: Scaffold(
              appBar: AppBar(
                title: Text('search'),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                // child: Column(
                //   children: [
                //     TextFormField(
                //       keyboardType: TextInputType.text,
                //       controller: searchController,
                //       validator: (value) {
                //         if (value?.isEmpty ?? true) {
                //           return 'please enter some text';
                //         }
                //       },
                //       onFieldSubmitted: (value) {
                //         SearchCubit.get(context).search(value);
                //       },
                //       decoration: const InputDecoration(
                //         border: OutlineInputBorder(),
                //         prefixIcon: Icon(Icons.search),
                //       ),
                //     ),
                //     SizedBox(
                //       height: 15,
                //     ),
                //     if (state is SearchLoadingState) LinearProgressIndicator(),
                //     SizedBox(
                //       height: 15,
                //     ),
                //     //body of search items
                //     if (state is SearchSuccessState)
                //       Expanded(
                //         child: ListView.separated(
                //           itemBuilder: (context, index) => buildListItem(
                //               SearchCubit.get(context)
                //                   .model
                //                   ?.data
                //                   ?.data?[index],
                //               isOldPrice: false,
                //               context),
                //           separatorBuilder: (context, index) => mySeparator(),
                //           itemCount: SearchCubit.get(context)
                //                   .model
                //                   ?.data
                //                   ?.data
                //                   ?.length ??
                //               0,
                //         ),
                //       )
                //   ],
                // ),
              ),
            ),
          );
        },
      ),
    );
  }
}
