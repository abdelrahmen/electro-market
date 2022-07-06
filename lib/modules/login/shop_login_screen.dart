import 'package:electro_market/modules/login/cubit/cubit.dart';
import 'package:electro_market/modules/login/cubit/states.dart';
import 'package:electro_market/modules/register/shop_register_screen.dart';
import 'package:electro_market/shared/components/components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopLoginScreen extends StatelessWidget {
  ShopLoginScreen({Key? key}) : super(key: key);

  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit, ShopLoginStates>(
        listener: (context, state) {
          // TODO: implement listener
          if (state is ShopLoginSuccessState) {
            if (state.loginModel.status) {
              print(state.loginModel.status);
              print(state.loginModel.message);
              flutterToast(
                msg: state.loginModel.message,
                color: Colors.green,
              );
            } else {
              print(state.loginModel.message);
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
                          'LOGIN',
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(color: Colors.black),
                        ),
                        Text(
                          'login to see the newest offers',
                          style: Theme.of(context).textTheme.caption!.copyWith(
                                color: Colors.grey,
                              ),
                        ),
                        const SizedBox(
                          height: 30,
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
                                ShopLoginCubit.get(context)
                                    .changePassVissibitlty();
                              },
                              icon: Icon(
                                ShopLoginCubit.get(context).suffixIcon,
                              ),
                            ),
                          ),
                          keyboardType: TextInputType.visiblePassword,
                          onFieldSubmitted: (value) {
                            if (formKey.currentState!.validate()) {
                              ShopLoginCubit.get(context).userLogin(
                                email: emailController.text,
                                password: passwordController.text,
                              );
                            }
                          },
                          obscureText: ShopLoginCubit.get(context).hidden,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        //the login button
                        (state is! ShopLoginLoadingState
                            ? defaultButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    ShopLoginCubit.get(context).userLogin(
                                      email: emailController.text,
                                      password: passwordController.text,
                                    );
                                  }
                                },
                                text: 'LOGIN',
                              )
                            : const Center(child: CircularProgressIndicator())),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("don't have an account?"),
                            defaultTextButton(
                              onPressed: () {
                                navigateTO(context, const RegisterScreen());
                              },
                              text: "register now",
                            ),
                          ],
                        ),
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
