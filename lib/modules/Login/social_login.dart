import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/layout/Social_layout.dart';
import 'package:firebase1/modules/Register/Social_register.dart';
import 'package:firebase1/shared/componnents0/components.dart';
import 'package:firebase1/shared/network/local/cache_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubic_login/cubic.dart';
import 'cubic_login/states.dart';

class SocialLogin extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SocialLoginCubic(),
        child: BlocConsumer<SocialLoginCubic, SocialLoginStates>(
          listener: (context, state) {
            if (state is SocialLoginErrorState) {
              ShowToast(text: state.error, state: Toaststates.ERROR);
            }
            if (state is SocialLoginSuccessState) {
              CacheHelper.saveData(key: 'uId', value: state.uId).then((value) {
                navigateAndFinish(context,Socail_layout());
              });
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
                      key: formkey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline4!
                                .copyWith(color: Colors.black),
                          ),
                          Text(
                            'Login now to Communicate with Friends',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'please enter your email address';
                                }
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined),
                          SizedBox(
                            height: 15,
                          ),
                          defaultFormField(
                              isPassword:
                                  SocialLoginCubic.get(context).isPassword,
                              onSubmit: (value) {
                                if (formkey.currentState!.validate()) {}
                              },
                              controller: passwordController,
                              suffix: SocialLoginCubic.get(context).suffix,
                              suffixPressed: () {
                                SocialLoginCubic.get(context)
                                    .changePasswordvisibility();
                              },
                              type: TextInputType.visiblePassword,
                              validate: (value) {
                                if (value.isEmpty) {
                                  return 'password is too short ';
                                }
                              },
                              label: 'password',
                              prefix: Icons.lock_outline),
                          SizedBox(
                            height: 30,
                          ),
                          ConditionalBuilder(
                              condition: state is! SocialLoginILoadingState,
                              builder: (context) => defaultButton(
                                  function: () {
                                    if (formkey.currentState!.validate()) {
                                      print(passwordController.text);
                                      SocialLoginCubic.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'login',
                                  isUpperCase: true),
                              fallback: (context) =>
                                  Center(child: CircularProgressIndicator())),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Don`t have an account?',
                                style: TextStyle(fontSize: 12),
                              ),
                              TextButton(
                                  onPressed: () {
                                    navigateTo(context, Social_register());
                                  },
                                  child: Text(
                                    'register',
                                    style: TextStyle(fontSize: 12),
                                  ))
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
        ));
  }
}
