
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_app/cubit/cubit.dart';
import 'package:social_app/layouts/social_app/cubit/states.dart';
import 'package:social_app/shared/components/components.dart';
import 'package:social_app/shared/styles/IconBroken.dart';

class EditProfileScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    var nameController=TextEditingController();
    var phoneController=TextEditingController();
    var bioController=TextEditingController();
    var userModel=SocialCubit.get(context).userModel;
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (context,state){},
      builder:(context,state) {
        var profileImage=SocialCubit.get(context).profileImage;
        var coverImage=SocialCubit.get(context).coverImage;
        nameController.text=userModel.name!;
        phoneController.text=userModel.phone!;
        bioController.text=userModel.bio!;
      return  Scaffold(
            appBar: defaultAppBar(
              actions: [
                defaultTextButton(
                    text: 'Update',
                    onPressed: () {
                      SocialCubit.get(context).updateUser(
                          name: nameController.text,
                          phone: phoneController.text,
                          bio: bioController.text,
                      );
                    }
                ),
                SizedBox(
                  width: 15.0,
                ),
              ],
              title: 'Edit Profile',
              context: context,
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    if (state is SocialUserUpdateLoadingState)
                    LinearProgressIndicator(),
                    if (state is SocialUserUpdateLoadingState)
                      SizedBox(height: 10.0,),
                    Container(
                      height: 190.0,
                      child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            alignment: AlignmentDirectional.topCenter,
                            child: Stack(
                              alignment: AlignmentDirectional.topEnd,
                              children:[
                                Container(
                                height: 140.0,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4.0),
                                    topRight: Radius.circular(4.0),
                                  ),
                                  image: DecorationImage(
                                    image: coverImage ==null? NetworkImage('${userModel.cover}'): FileImage(coverImage) as ImageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                                IconButton(
                                  onPressed: (){
                                    SocialCubit.get(context).getCoverImage();
                                  },
                                  icon: CircleAvatar(
                                      child: Icon(IconBroken.Camera),
                                    radius: 20.0,
                                  ),
                                ),
                        ],
                            ),
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                              radius: 64.0,
                              backgroundColor: Theme
                                  .of(context)
                                  .scaffoldBackgroundColor,
                              child: CircleAvatar(
                                radius: 60.0,
                                backgroundImage:profileImage ==null? NetworkImage(
                                    '${userModel.image}',
                                ) : FileImage(profileImage) as ImageProvider,
                              ),
                            ),
                              IconButton(
                                onPressed: (){
                                  SocialCubit.get(context).getProfileImage();
                                },
                                icon: CircleAvatar(
                                  child: Icon(IconBroken.Camera),
                                  radius: 20.0,
                                ),
                              ),


                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0,),
                    if (SocialCubit.get(context).coverImage !=null || SocialCubit.get(context).profileImage !=null)
                    Row(
                      children: [
                        if(SocialCubit.get(context).profileImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                function: (){
                                  SocialCubit.get(context).uploadProfileImage(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                },
                                text: 'upload profile'),
                            if(state is SocialUserUpdateLoadingState)
                            SizedBox(height: 3.0,),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
        ]
                          ),
                        ),
                        SizedBox(width:5.0),
                        if(SocialCubit.get(context).coverImage !=null)
                        Expanded(
                          child: Column(
                            children: [
                              defaultButton(
                                  function: (){
                                    SocialCubit.get(context).uploadProfileCover(name: nameController.text, phone: phoneController.text, bio: bioController.text);
                                  },
                                  text: 'upload cover'),
                              if(state is SocialUserUpdateLoadingState)
                                SizedBox(height: 3.0,),
                              if(state is SocialUserUpdateLoadingState)
                                LinearProgressIndicator(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    if (SocialCubit.get(context).coverImage !=null || SocialCubit.get(context).profileImage !=null)
                      SizedBox(height: 20.0,),
                    defaultFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'bio must not be empty';
                          }
                        },
                        controller: bioController,
                        type: TextInputType.text,
                        isPassword: false,
                        label: 'Bio',
                        prefix: IconBroken.Info_Circle
                    ),
                    SizedBox(height: 10.0,),

                    defaultFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'name must not be empty';
                          }
                        },

                        controller: nameController,
                        type: TextInputType.name,
                        label: 'Name',
                        isPassword: false,
                        prefix: IconBroken.User
                    ),

                    SizedBox(height: 10.0,),

                    defaultFormField(
                        validator: (value){
                          if(value!.isEmpty){
                            return 'phoneNumber must not be empty';
                          }
                        },

                        controller: phoneController,
                        type: TextInputType.number,
                        label: 'phone',
                        isPassword: false,
                        prefix: IconBroken.Call
                    ),
                  ],
                ),
              ),
            )

        );
      }
    );
  }
}
