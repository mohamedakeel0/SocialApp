

abstract class SocialLoginStates{}
class SocialLoginInitailState extends SocialLoginStates{}
class SocialLoginILoadingState extends SocialLoginStates{}
class SocialLoginSuccessState extends SocialLoginStates{

final String uId;

  SocialLoginSuccessState(this.uId);
}
class SocialLoginErrorState extends SocialLoginStates{
  final String error;
  SocialLoginErrorState(this.error);
}
class SocialChangePasswordVisibilityState extends SocialLoginStates{}