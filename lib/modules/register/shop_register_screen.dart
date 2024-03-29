import 'package:electro_market/layout/cubit/cubit.dart';
import 'package:electro_market/layout/shop_layout.dart';
import 'package:electro_market/modules/register/cubit/cubit.dart';
import 'package:electro_market/modules/register/cubit/states.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:electro_market/shared/components/constants.dart';
import 'package:electro_market/shared/netwok/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit, ShopRegisterStates>(
        listener: (context, state) {
          if (state is ShopRegisterSuccessState) {
            if (state.model.status) {
              CacheHelper.saveData(
                      key: 'token', value: state.model.data?.token)
                  .then((value) {
                    token = state.model.data?.token;
                navigateWithNoBack(
                  context,
                  ShopLayout(),
                );
              });
              flutterToast(
                msg: state.model.message,
                color: Colors.green,
              );
            } else {
              print(state.model.message);
              flutterToast(msg: state.model.message);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'REGISTER',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'Register to see the newest offers',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        //name form field
                        TextFormField(
                          controller: nameController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your name";
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Name"),
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.name,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //email form field
                        TextFormField(
                          controller: emailController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your email";
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Email Address"),
                            prefixIcon: Icon(Icons.email_outlined),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //password form field
                        TextFormField(
                          controller: passwordController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "enter a valid password";
                            }
                          },
                          decoration: InputDecoration(
                            label: const Text("Password"),
                            prefixIcon: const Icon(Icons.lock_outline),
                            border: const OutlineInputBorder(),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ShopRegisterCubit.get(context)
                                    .changePassVissibitlty();
                              },
                              icon: Icon(
                                ShopRegisterCubit.get(context).suffixIcon,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value) {},
                          obscureText: ShopRegisterCubit.get(context).hidden,
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        //phone form field
                        TextFormField(
                          controller: phoneController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "please enter your phone";
                            }
                          },
                          decoration: const InputDecoration(
                            label: Text("Phone"),
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //the register button
                        (state is! ShopRegisterLoadingState)
                            ? defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopRegisterCubit.get(context).userRegister(
                                      name: nameController.text,
                                      email: emailController.text,
                                      password: passwordController.text,
                                      phone: phoneController.text,
                                    );
                                    // ShopCubit.get(context).getUserData();
                                    // ShopCubit.get(context).getHomeData();
                                    // ShopCubit.get(context).getCategories();
                                    // ShopCubit.get(context).currentIndex=0;
                                  }
                                },
                                text: 'REGISTER',
                              )
                            : const Center(child: CircularProgressIndicator()),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
