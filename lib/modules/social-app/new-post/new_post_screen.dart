import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_app/cubit/cubit.dart';
import 'package:social_app/layouts/social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/IconBroken.dart';

class NewPostScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var textController= TextEditingController();
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
        builder: (context,state){
        return Scaffold(
          appBar: defaultAppBar(
            context: context,
            title: 'Create Post',
            actions: [
              defaultTextButton(
                  text: 'POST',
                  onPressed: (){
                    var now=DateTime.now();

                    if(SocialCubit.get(context).postImage == null){
                      SocialCubit.get(context).createPost(
                          dateTime:now.toString() ,
                          text: textController.text,
                      );
                    }else{
                      SocialCubit.get(context).uploadPostImage(
                          dateTime: now.toString(),
                          text: textController.text,
                      );
                    }
                  }
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is SocialCreatePostLoadingState)
                LinearProgressIndicator(),
                if(state is SocialCreatePostLoadingState)
                  SizedBox(height: 10.0,),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/gorgeous-graceful-woman-with-healthy-blond-wavy-hairs-standing-pink-wall_273443-1744.jpg'
                      ),
                    ),
                    SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Text(
                        'Salman Ali',
                        style: TextStyle(
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                    ),
                  ],
                ),
                Expanded(
                  child: TextFormField(
                    controller: textController,
                    decoration: InputDecoration(
                      hintText: 'What is on your mind',
                      border: InputBorder.none
                    ),
                  ),
                ),
                SizedBox(height: 10.0,),
                if(SocialCubit.get(context).postImage != null)
                Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children:[
                    if (SocialCubit.get(context).postImage != null)
                    Container(
                      height: 140.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.0),
                        image: DecorationImage(

                          image: FileImage(SocialCubit.get(context).postImage!),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: (){
                        SocialCubit.get(context).removePostImage();
                      },
                      icon: CircleAvatar(
                        child: Icon(Icons.close),
                        radius: 20.0,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0,),

                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                          onPressed: (){
                            SocialCubit.get(context).getPostImage();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(IconBroken.Image),
                              SizedBox(width: 5.0,),
                              Text('Add photo')
                            ],
                          ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                           child: Text('# tags')

                        ),
                    ),


                  ],
                ),
              ],
            ),
          ),
        );
        },
    );
  }
}
