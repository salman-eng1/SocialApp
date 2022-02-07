import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/modules/social-app/new-post/new_post_screen.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/IconBroken.dart';

import 'cubit/cubit.dart';
import 'cubit/states.dart';

class SocialLayout extends StatelessWidget {
  const SocialLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, Object? state) {
        if(state is SocialNewPostState){
          navigateTo(context, NewPostScreen());
        }
      },
      builder: (BuildContext context, state) {
        var cubit=SocialCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
            actions: [
              IconButton(
                  onPressed: (){},
                  icon: Icon(IconBroken.Notification),
              ),
              IconButton(
                onPressed: (){},
                icon: Icon(IconBroken.Search),
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeBottomNav(index);
            },
            items: [
              BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chats'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Users'),
              BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Settings'),


            ],),
        );

      },
    );
  }
}
