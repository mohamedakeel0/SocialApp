import 'dart:math';


import 'package:firebase1/view/Login/cubic_login/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SocialLoginCubic extends Cubit<SocialLoginStates> {
  SocialLoginCubic() : super(SocialLoginInitailState());

  static SocialLoginCubic get(context) => BlocProvider.of(context);

  void userLogin({required String email, required String password}) {
    emit(SocialLoginILoadingState());
    FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
          emit(SocialLoginSuccessState(value.user!.uid));

    })
        .catchError((error) {
      emit(SocialLoginErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordvisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialChangePasswordVisibilityState());
  }
}
