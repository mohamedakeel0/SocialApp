

abstract class SocialRegisterStates{}
class SocialRegisterInitailState extends SocialRegisterStates{}
class SocialRegisterILoadingState extends SocialRegisterStates{}
class SocialRegisterSuccessState extends SocialRegisterStates{


}
class SocialRegisterErrorState extends SocialRegisterStates{
  final String error;
  SocialRegisterErrorState(this.error);
}
class  SocialCreateUserSuccessState extends SocialRegisterStates{
}
class SocialCreateUserErrorState extends SocialRegisterStates{
  final String error;
  SocialCreateUserErrorState(this.error);
}
class SocialRegisterChangePasswordVisibilityState extends SocialRegisterStates{}