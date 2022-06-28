import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/models/social_user_model.dart';
import 'package:firebase1/modules/Register/cubic_register/states.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class SocialRegisterCubic extends Cubit<SocialRegisterStates> {
  SocialRegisterCubic() : super(SocialRegisterInitailState());

  static SocialRegisterCubic get(context) => BlocProvider.of(context);

  void userRegister(
      {required String email,
      required String password,
      required name,
      required phone}) {
    emit(SocialRegisterILoadingState());
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      print(value.user!.email);
      print(value.user!.uid);
      CreateUser(
        uId: value.user!.uid,
        phone: phone,
        email: email,
        name: name,
      );
    }).catchError((error) {
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void CreateUser({
    required String email,
    required String name,
    required String phone,
    required String uId,
  }) {
    SocialUserModel model = SocialUserModel(
        name: name,
        email: email,
        phone: phone,
        uId: uId,
        isEmailVerifies: false,
        cover: 'https://img.freepik.com/free-photo/cheerful-male-gives-nice-offer-advertises-new-product-sale-stands-torn-paper-hole-has-positive-expression_273609-38452.jpg?t=st=1650633237~exp=1650633837~hmac=581ebed5affe340d221e05df8b37300ab6f42cc93fcde6dcaa5f6efa031d311b&w=1060',
        image:
            'https://as2.ftcdn.net/v2/jpg/02/94/57/87/1000_F_294578784_8wDw0TyKboYKya0cB741X5SPjXf0MRSK.jpg',
        bio: 'write you bio ...');
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUserSuccessState());
    }).catchError((error) {
      emit(SocialCreateUserErrorState(error.toString()));
    });
  }

  IconData suffix = Icons.visibility_outlined;
  bool isPassword = true;

  void changePasswordvisibility() {
    isPassword = !isPassword;
    suffix = isPassword ? Icons.visibility_outlined : Icons.visibility_off;
    emit(SocialRegisterChangePasswordVisibilityState());
  }
}
