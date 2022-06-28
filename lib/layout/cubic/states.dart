abstract class SocailStates{}
class SocialInitailState extends SocailStates{}
class SocialGetUserLoadingState extends SocailStates{}
class SocialChangeBottomNavState extends SocailStates{}
class SocialGetUserSuccessState extends SocailStates{

}
class SocialGetUserErrorState extends SocailStates{
  final String error;
  SocialGetUserErrorState(this.error);
}
class SocialNewPostState extends SocailStates{}
class SocialProfileImagePickedSuccessState extends SocailStates{}
class SocialProfileImagePickedErrorState extends SocailStates{}
class SocialCoverImagePickedSuccessState extends SocailStates{}
class SocialCoverImagePickedErrorState extends SocailStates{}
class SocialUploadProfileImagePickedSuccessState extends SocailStates{}
class SocialUploadProfileImagePickedErrorState extends SocailStates{
  final String error;
  SocialUploadProfileImagePickedErrorState(this.error);
}
class SocialUploadCoverImagePickedSuccessState extends SocailStates{}
class SocialUploadCoverImagePickedErrorState extends SocailStates{
  final String error;
  SocialUploadCoverImagePickedErrorState(this.error);
}
class SocialUserupdataErrorState extends SocailStates{
  final String error;
  SocialUserupdataErrorState(this.error);
}

class SocialUserupdataLoadingState extends SocailStates{}
//CreatePost
class SocialCreatePostLoadingState extends SocailStates{}

class SocialCreatePostSuccessState extends SocailStates{

}
class SocialCreatePostErrorState extends SocailStates{
  final String error;
  SocialCreatePostErrorState(this.error);
}
class SocialPostImagePickedLoadingState extends SocailStates{}
class SocialPostImagePickedSuccessState extends SocailStates{}

class SocialPostImagePickedErrorState extends SocailStates{}
class  SocialRemovePostImageState extends SocailStates{}
class SocialGetPostsLoadingState extends SocailStates{}
class SocialGetPostsSuccessState extends SocailStates{}
class SocialGetPostsErrorState extends SocailStates{
  final String error;
  SocialGetPostsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocailStates{}
class SocialLikePostErrorState extends SocailStates{
  final String error;
  SocialLikePostErrorState(this.error);
}
class SocialCommentPostSuccessState extends SocailStates{}
class SocialCommentPostErrorState extends SocailStates{
  final String error;
  SocialCommentPostErrorState(this.error);
}
class SocialGetAllUserLoadingState extends SocailStates{}
class SocialGetAllUserSuccessState extends SocailStates{}
class SocialGetAllUserErrorState extends SocailStates{
  final String error;
  SocialGetAllUserErrorState(this.error);
}
//chat
class SocialSendMessageSuccessState extends SocailStates{}
class SocialSendMessageErrorState extends SocailStates{
  final String error;
  SocialSendMessageErrorState(this.error);
}
class SocialGetMessageSuccessState extends SocailStates{}
class SocialMessageImagePickedSuccessState extends SocailStates{}
class SocialMessageImagePickedErrorState extends SocailStates{}
class  SocialRemoveMessageImageState extends SocailStates{}
class SocialMessageImageLoadingState extends SocailStates{}
class SocialMessageImageSuccessState extends SocailStates{}
class SocialMessageImageErrorState extends SocailStates{
  final String error;
  SocialMessageImageErrorState(this.error);
}