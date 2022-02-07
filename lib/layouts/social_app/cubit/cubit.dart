import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/layouts/social_app/cubit/states.dart';
import 'package:social_app/models/social_app/User_Model.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/modules/social-app/chats/chats_screen.dart';
import 'package:social_app/modules/social-app/feeds/feeds_screen.dart';
import 'package:social_app/modules/social-app/new-post/new_post_screen.dart';
import 'package:social_app/modules/social-app/settings/settings_sscreen.dart';
import 'package:social_app/modules/social-app/users/users_screen.dart';
import 'package:social_app/shared/components/constants.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class SocialCubit extends Cubit<SocialStates>
{
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) =>BlocProvider.of(context);
      late SocialUserModel userModel ;

  void getUserData()
  async
  {
    emit(SocialGetUserLoadingState());

    FirebaseFirestore.instance.
    collection('users')
        .doc(uId)
        .get()
        .then((value){
          userModel=SocialUserModel.fromJson(value.data());
          print(userModel.phone);
          emit(SocialGetUserSuccessState());
    })
        .catchError((error){
          print(error.toString());
          emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex= 0;

  List<Widget> screens=[
    FeedsScrees(),
    ChatsScreen(),
    NewPostScreen(),
    UsersScreen(),
    SettingsScreen(),
  ];
  List<String> titles=[
    'Home',
    'Chats',
    'Post',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index)
  {
    if(index ==2)
      emit(SocialNewPostState());
    else{
      currentIndex= index;

      emit(SocialChangeBottomNavState());

    }

  }

    File? profileImage;
  var picker=ImagePicker();

  Future<void> getProfileImage() async{
    final pickedFile =await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile !=null){
      profileImage=File(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    }else{
      print('no image selected');
      emit(SocialProfileImagePickedErrorState());
    }

  }

  File? coverImage;

  Future<void> getCoverImage() async{
    final pickedFile =await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile !=null){
      coverImage=File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    }else{
      print('no image selected');
      emit(SocialCoverImagePickedErrorState());
    }

  }


  void uploadProfileImage ({
    required String name,
    required String phone,
    required String bio,
})  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
          value.ref.getDownloadURL()
              .then((value){
                // emit(SocialUploadImagePickedSuccessState());
                updateUser(
                    phone: phone,
                    name: name,
                    bio: bio,
                  image: value,
                );
          })
              .catchError((error){
                emit(SocialUploadImagePickedErrorState());
          });
      }).catchError((error){
      emit(SocialUploadImagePickedErrorState());
    });
  }

  void uploadProfileCover ({
    required String name,
    required String phone,
    required String bio,
})  {
    emit(SocialUserUpdateLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('users/cover/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value){
        // emit(SocialUploadCoverPickedSuccessState());
        updateUser(
            name: name,
            phone: phone,
            bio: bio,
          cover: value,
        );
          })
          .catchError((error){
        emit(SocialUploadCoverPickedErrorState());
      });
    }).catchError((error){
      emit(SocialUploadCoverPickedErrorState());
    });
  }

// void updateUserImages({
//   required String name,
//   required String phone,
//   required String bio,
// }){
//     emit(SocialUserUpdateLoadingState());
//     if(coverImage !=null){
//       uploadProfileCover();
//       print(coverImageUrl);
//     }
//     else if(profileImage !=null){
//       uploadProfileImage();
//       print(profileImage);
//     }
//     else if(coverImage !=null && profileImage !=null)
//     {
//       // print('${coverImageUrl}${coverImageUrl}${profileImage}${profileImage}');
//     }
//     else{
//       print('cover and profile images is null');
//       SocialUserModel model=SocialUserModel(
//         name:name,
//         phone:phone,
//         isEmailVerified:false,
//         bio: bio,
//         email: userModel.email,
//         cover: userModel.cover,
//         image: userModel.image,
//         uId: userModel.uId,
//       );
//       FirebaseFirestore.instance
//           .collection('users')
//           .doc(model.uId)
//           .update(model.toMap())
//           .then((value){
//         getUserData();
//       })
//           .catchError((error){
//         emit(SocialUserUpdateErrorState());
//       });
//     }
//   SocialUserModel model=SocialUserModel(
//     name:name,
//     phone:phone,
//     image: profileImageUrl,
//     cover: coverImageUrl,
//     isEmailVerified:false,
//     bio: bio,
//     uId: userModel.uId,
//       email:userModel.email,
//   );
//     FirebaseFirestore.instance
//         .collection('users')
//         .doc(model.uId)
//         .update(model.toMap())
//     .then((value){
//       updateUser(name: name, phone: phone, bio: bio);
//     })
//   .catchError((error){
//     emit(SocialUserUpdateErrorState());
//     });
// }
//

void updateUser({
  required String name,
  required String phone,
  required String bio,
  String? cover,
  String? image,
}){
  SocialUserModel model=SocialUserModel(
    name:name,
    phone:phone,
    bio: bio,
    email:userModel.email,
    image: image?? userModel.image,
    cover: cover?? userModel.cover,
    uId: userModel.uId,
    isEmailVerified:false,
  );
  FirebaseFirestore.instance
      .collection('users')
      .doc(model.uId)
      .update(model.toMap())
      .then((value){
    getUserData();
  })
      .catchError((error){
    emit(SocialUserUpdateErrorState());
  });
}





  File? postImage;

  Future<void> getPostImage() async{
    final pickedFile =await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile !=null){
      postImage=File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialPostImagePickedSuccessState());
    }else{
      print('no image selected');
      emit(SocialPostImagePickedErrorState());
    }

  }
void removePostImage(){
    postImage=null;
    emit(SocialRemovePostImageState());
}

  void uploadPostImage ({
    required String dateTime,
    required String text,
  }){
    emit(SocialCreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL()
          .then((value){
       print(value);
       createPost(
           dateTime: dateTime,
           text: text,
         postImage: value,
       );
      })
          .catchError((error){
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }


  void createPost({
    required String dateTime,
    required String text,
    String? postImage,
  }){
    emit(SocialCreatePostLoadingState());
    PostModel model=PostModel(
      name:userModel.name,
      uId:userModel.uId,
      image:userModel.image,
      dateTime:dateTime,
      text: text,
      postImage: postImage??'',
    );
    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value){
          emit(SocialCreatePostSuccessState());
    })
        .catchError((error){
      emit(SocialCreatePostErrorState());
    });
  }

  List<PostModel> posts =[];
  List<String> postsId =[];
  List<int> likes=[];

  void getPostsData()
async{
    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('posts')
        .get()
        .then((value){
      value.docs.forEach((element){
        element.reference.collection('Likes').get().then((value){
          likes.add(value.docs.length);
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
          print(likes.toString());
              emit(SocialGetPostsSuccessState());

        });

          });
    }).catchError((error){
      emit(SocialGetPostsErrorState(error));
    });
}

void likePosts(String postId)
async{
  FirebaseFirestore.instance
      .collection('posts')
      .doc(postId)
      .collection('likes')
      .doc(userModel.uId)
      .set({
    'like':true,
  })
      .then((value){
        emit(SocialLikePostsSuccessState());
  })
      .catchError((error){
        emit(SocialLikePostsErrorState(error));
  });
}

List<SocialUserModel>users=[];

  void getAllUsers()
  async {


    emit(SocialGetPostsLoadingState());
    FirebaseFirestore.instance.collection('users')
        .get()
        .then((value){
      value.docs.forEach((element){

          users.add(SocialUserModel.fromJson(element.data()));
          emit(SocialGetAllUserSuccessState());

      });

    }).catchError((error){
      emit(SocialGetAllUserErrorState(error));
    });

  }
}
