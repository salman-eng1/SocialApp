import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_app/social_layout.dart';
import 'package:social_app/shared/bloc_observe.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:social_app/shared/network/local/cache_helper.dart';
import 'package:social_app/shared/styles/thems.dart';


import 'layouts/social_app/cubit/cubit.dart';
import 'modules/social-app/social_login/social_login_screen.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message)async{
  print(message.data.toString());
  print('onBackgroundMessage');
  showToast(message: 'on Background Message', state: ToastStates.SUCCESS);
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  var fcm_token= await FirebaseMessaging.instance.getToken();
  print(fcm_token);
  FirebaseMessaging.onMessage.listen((event) {
    print(event.data.toString());
    showToast(message: 'on Message', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {
    print(event.data.toString());
    showToast(message: 'on Message opened', state: ToastStates.SUCCESS);
  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  print(fcm_token);
  await CacheHelper.init();
  Widget widget;


  bool? isDark=CacheHelper.getData(key: 'isDark');

  uId=CacheHelper.getData(key: 'uId');


  if (uId != null)
    {
      widget = SocialLayout();
    }else{
    widget = SocialLoginScreen();
    print(uId);
  }

  BlocOverrides.runZoned(
        () {
          runApp(MyApp(
          isDark: isDark,
            startWidget: widget,));

        },


    blocObserver: MyBlocObserver(),
  );



}


class MyApp extends StatelessWidget{

  final bool? isDark;
  final Widget? startWidget;

  MyApp({this.isDark,this.startWidget});
  @override
  Widget build(BuildContext context) {

    return

        BlocProvider(create: (context)=>SocialCubit()..getUserData()..getPostsData(),



        child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: ThemeMode.light,
              home:startWidget,
        ),

        );
  }

}