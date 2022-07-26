import 'package:electro_market/layout/cubit/cubit.dart';
import 'package:electro_market/layout/cubit/states.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:electro_market/shared/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsScreen extends StatelessWidget {
  SettingsScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var model = ShopCubit.get(context).userModel;

        nameController.text = '${model?.data?.name}';
        emailController.text = '${model?.data?.email}';
        phoneController.text = '${model?.data?.phone}';
        return (ShopCubit.get(context).userModel == null)
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        if (state is ShopLoadingUpdateUserDataState)
                          LinearProgressIndicator(),
                          SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.name,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'please enter the new name';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  label: Text('Name'),
                                  prefixIcon: Icon(Icons.person),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'please enter the new email';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  label: Text('Email Address'),
                                  prefixIcon: Icon(Icons.email),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          height: 70,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10)),
                          child: Center(
                            child: TextFormField(
                              controller: phoneController,
                              keyboardType: TextInputType.phone,
                              validator: (value) {
                                if (value?.isEmpty ?? false) {
                                  return 'please enter the new phone';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                  label: Text('Phone'),
                                  prefixIcon: Icon(Icons.phone),
                                  border: InputBorder.none),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //update button
                        defaultButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              ShopCubit.get(context).updateUserData(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                              );
                            }
                          },
                          text: 'Update',
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        //sign out button
                        defaultButton(
                          onPressed: () {
                            signOut(context);
                          },
                          text: 'Sign Out',
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
