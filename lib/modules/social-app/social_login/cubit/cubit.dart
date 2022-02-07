import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social-app/social_login/cubit/states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates>{
  SocialLoginCubit() : super(SocialLoginInitState());

static SocialLoginCubit get(context)=>BlocProvider.of(context);
  void userLogin({
    required String email,
    required String password,
  }){
    emit(SocialLoginLoadingState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {
      emit(SocialLoginSuccessState(value.user!.uid));
    })
        .catchError((error){
          print(error.toString());
          print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });
  }

IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_off:Icons.visibility_off_outlined;
    emit(SocialChangePasswordVisibilityState());
}
}