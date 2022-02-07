import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/modules/social-app/social_register/cubit/states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates>{
  SocialRegisterCubit() : super(SocialRegisterInitState());

static SocialRegisterCubit get(context)=>BlocProvider.of(context);


void userRegister({
  required String name,
  required String email,
  required String password,
  required String phone,
}){
  emit(SocialRegisterLoadingState());
  FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: password,
  )
      .then((value) {
    print(value.user!.email);
        print(value.user!.uid);
        userCreate(
            name:name,
            email:email,
            phone: phone,
            uId: value.user!.uid,
        );
        // emit(SocialRegisterSuccessState());
  })
      .catchError((error){
        emit(SocialRegisterErrorState(error.toString()));
        print(error);
  });
}

void userCreate({
   required String name,
   required String email,
   required String phone,
   required String uId,
}){
  SocialUserModel model=SocialUserModel(
      name:name,
      email:email,
      phone:phone,
      uId:uId,
    image: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?size=338&ext=jpg&ga=GA1.2.959574492.1636612920',
    cover:'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg?size=338&ext=jpg&ga=GA1.2.959574492.1636612920',
    isEmailVerified:false,
    bio: 'write your bio',
  );
FirebaseFirestore.instance
    .collection('users')
    .doc(uId)
    .set(
  model.toMap()
)
    .then((value){
      print(model.name);
      print(model.uId);
      emit(SocialCreateUserSuccessState());
})
    .catchError((error){
      emit(SocialCreateUserErrorState(error.toString()));
      print(error.toString());
});
}

IconData suffix=Icons.visibility_outlined;
  bool isPassword=true;
  void changePasswordVisibility(){
    isPassword=!isPassword;
    suffix= isPassword?Icons.visibility_off:Icons.visibility_off_outlined;
    emit(SocialRegisterChangePasswordVisibilityState());
}
}