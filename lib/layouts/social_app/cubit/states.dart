abstract class SocialStates{}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates
{
  final String error ;
  SocialGetUserErrorState(this.error);
}


class SocialGetAllUserLoadingState extends SocialStates{}

class SocialGetAllUserSuccessState extends SocialStates{}

class SocialGetAllUserErrorState extends SocialStates
{
  final String error ;
  SocialGetAllUserErrorState(this.error);
}
class SocialNewPostState extends SocialStates{}

class SocialChangeBottomNavState extends SocialStates{}

class SocialProfileImagePickedSuccessState extends SocialStates{}

class SocialProfileImagePickedErrorState extends SocialStates{}

class SocialCoverImagePickedSuccessState extends SocialStates{}

class SocialCoverImagePickedErrorState extends SocialStates{}

class SocialUploadImagePickedSuccessState extends SocialStates{}

class SocialUploadImagePickedErrorState extends SocialStates{}

class SocialUploadCoverPickedSuccessState extends SocialStates{}

class SocialUploadCoverPickedErrorState extends SocialStates{}

class SocialUserUpdateErrorState extends SocialStates{}
class SocialUserUpdateLoadingState extends SocialStates{}



//create post
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostImagePickedSuccessState extends SocialStates{}

class SocialPostImagePickedErrorState extends SocialStates{}
class SocialRemovePostImageState extends SocialStates{}



//get posts
class SocialGetPostsLoadingState extends SocialStates{}

class SocialGetPostsSuccessState extends SocialStates{}

class SocialGetPostsErrorState extends SocialStates
{
  final String error ;
  SocialGetPostsErrorState(this.error);
}
class SocialLikePostsSuccessState extends SocialStates{}

class SocialLikePostsErrorState extends SocialStates
{
  final String error ;
  SocialLikePostsErrorState(this.error);
}
class SocialGetLikesLoadingState extends SocialStates{}

class SocialGetLikesSuccessState extends SocialStates{}

class SocialGetLikesErrorState extends SocialStates
{
  final String error ;
  SocialGetLikesErrorState(this.error);
}