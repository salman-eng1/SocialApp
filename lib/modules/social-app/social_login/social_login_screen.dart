import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_app/social_layout.dart';
import 'package:social_app/modules/social-app/social_register/social_register_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/colors.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLoginScreen extends StatelessWidget {
  var formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=> SocialLoginCubit(),
      child: BlocConsumer<SocialLoginCubit,SocialLoginStates>(
          listener: (context, state) { 
            if(state is SocialLoginErrorState){
              showToast(
                  message: '${state.error.toString()}',
                  state: ToastStates.ERROR);
            }else
              if(state is SocialLoginSuccessState){
                showToast(message: 'you are logged in successfully', state: ToastStates.SUCCESS);
                CacheHelper.saveData(key: 'uId', value: state.uId)!
                    .then((value){
                      navigateAndFinish(context, SocialLayout());
                }).catchError((error){
                });
              }

          },
       builder : (context, Object? state) {
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
                          Text('LOGIN',
                            style: Theme.of(context).textTheme.headline3!.copyWith(color: defaultColor),
                          ),
                          Text('Login now to communicate with your friends',
                            style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.grey),
                          ),
                          SizedBox(height: 40.0,),
                          defaultFormField(
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'please enter email';
                              }
                            },
                            controller: emailController,
                            type: TextInputType.emailAddress,
                            label: 'Email',
                            prefix: Icons.email_outlined,
                            isPassword: false,
                          ),

                          SizedBox(height: 15.0,),

                          defaultFormField(
                            validator: (String? value){
                              if(value!.isEmpty){
                                return 'please enter password';
                              }
                            },
                            controller: passwordController,
                            type: TextInputType.visiblePassword,
                            suffix: SocialLoginCubit.get(context).suffix,
                            suffixPressed: (){
                              SocialLoginCubit.get(context).changePasswordVisibility();
                            },
                            isPassword:SocialLoginCubit.get(context).isPassword,
                            label: 'Password',
                            prefix: Icons.lock_clock_outlined,
                          ),
                          SizedBox(height: 30.0),
                          ConditionalBuilder(
                            builder: (BuildContext context)  =>
                                defaultButton(
                                  function: (){
                                    if(formkey.currentState!.validate()) {
                                      SocialLoginCubit.get(context).userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  text: 'login',
                                  background: defaultColor,
                                ),
                            condition: state is! SocialLoginLoadingState,
                            fallback: (context) => Center(child: CircularProgressIndicator()) ,

                          ),
                          SizedBox(height: 15.0,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Don't have account?"),
                              defaultTextButton(text: 'signup', onPressed: (){
                                navigateTo(context,SocialRegisterScreen());
                              })
                            ]
                            ,)


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
