import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase1/layout/cubic/states.dart';
import 'package:firebase1/models/MessageModel.dart';
import 'package:firebase1/models/post_model.dart';
import 'package:firebase1/models/social_user_model.dart';
import 'package:firebase1/modules/Newpost/newpost.dart';
import 'package:firebase1/modules/Settings/Settings_screen.dart';
import 'package:firebase1/modules/chats/Chats_screen.dart';
import 'package:firebase1/modules/feeds/Feeds_screen.dart';
import 'package:firebase1/modules/users/Users_screen.dart';
import 'package:firebase1/shared/componnents0/Constants.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class SocailCubic extends Cubit<SocailStates> {
  SocailCubic() : super(SocialInitailState());

  static SocailCubic get(context) => BlocProvider.of(context);
  late SocialUserModel Usermodel;

  Future<void> getUserData() async {
    emit(SocialGetUserLoadingState());
    log('error');

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) async {
      log('error000000000000');
      Usermodel = SocialUserModel.fromJson(value.data());
      log('error000000000000${Usermodel.toMap().toString()}');
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;
  List<Widget> screens = [
    Feeds_screen(),
    Chats_screen(),
    NewPost_Screen(),
    Users_screen(),
    Settings_screen(),
  ];
  List<String> titles = [
    'Home',
    'Chats',
    'posts',
    'Users',
    'Settings',
  ];

  void changeBottomNav(int index) {
    if (index == 1) getUsers();
    if (index == 2)
      emit(SocialNewPostState());
    else {
      currentIndex = index;
      emit(SocialChangeBottomNavState());
    }
  }

  File? profileImage;
  final picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialProfileImagePickedErrorState());
    }
  }

  File? coverImage;

  Future<void> getCoverImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      coverImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialCoverImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialCoverImagePickedErrorState());
    }
  }

  String profileImageUrl = '';

  void uploadProfileImage({
    required name,
    required bio,
    required phone,
  }) async {
    emit(SocialUserupdataLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        profileImageUrl = value;
        updataUser(name: name, bio: bio, phone: phone, image: value);
      }).catchError((error) {
        emit(SocialUploadProfileImagePickedErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialUploadProfileImagePickedErrorState(error.toString()));
    });
  }

  String coverImageUrl = '';

  void uploadCoverImage({
    required name,
    required bio,
    required phone,
  }) async {
    emit(SocialUserupdataLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(coverImage!.path).pathSegments.last}')
        .putFile(coverImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        print(value);
        coverImageUrl = value;
        updataUser(name: name, bio: bio, phone: phone, cover: value);
      }).catchError((error) {
        emit(SocialUploadCoverImagePickedErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialUploadCoverImagePickedErrorState(error.toString()));
    });
  }

  void updataUser({
    required name,
    required bio,
    required phone,
    String? cover,
    String? image,
  }) async {
    SocialUserModel model = SocialUserModel(
      name: name,
      bio: bio,
      phone: phone,
      uId: Usermodel.uId,
      email: Usermodel.email,
      isEmailVerifies: false,
      cover: cover ?? Usermodel.cover,
      image: image ?? Usermodel.image,
    );

    await FirebaseFirestore.instance
        .collection('users')
        .doc(Usermodel.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      log(error.toString());
      log(Usermodel.uId.toString());
      emit(SocialUserupdataErrorState(error.toString()));
    });
  }

  File? postImage;

  Future<void> getPostImage() async {

    final  pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    emit(SocialPostImagePickedLoadingState());
    if (pickedFile != null ) {

      postImage = await File(pickedFile.path);

      emit(SocialPostImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialPostImagePickedErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialRemovePostImageState());
  }

  void UploadPostImage({required dataTime, required text}) async {
    emit(SocialCreatePostLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        CeatePost(dataTime: dataTime, text: text, postImage: value);
        print(value);
      }).catchError((error) {
        emit(SocialCreatePostErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  void CeatePost({
    required dataTime,
    required text,
    String? postImage,
  }) async {
    emit(SocialCreatePostLoadingState());
    PostModel model = PostModel(
        name: Usermodel.name,
        uId: Usermodel.uId,
        image: Usermodel.image,
        dataTime: dataTime,
        text: text,
        postImage: postImage ?? '');

    await FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      log(error.toString());
      log(Usermodel.uId.toString());
      emit(SocialCreatePostErrorState(error.toString()));
    });
  }

  List<PostModel> posts = [];
  List<String> postsId = [];
  List<int> likes = [];
  List<int> comments = [];

  void getposts() {
    FirebaseFirestore.instance.collection('posts').orderBy('dataTime').get().then((value) {
      value.docs.forEach((element) {
        //  ; دا كدا هجيبلى Idالجديد  بتاع  post الى انا خليتع يتعمل لوحده
        print(element.id);
        // خش جوه element وهاتلى اصله وافتح collection الى اسمها LIKES هات الى جوها
        element.reference.collection('likes').get().then((value) {
          //  كدا انا جبت الى جواها الى هوه عدد LIKES لان كل LIKES ليه iDوهاتلى طولهم
          // كدا انا مسكت COLLECTION الى اسمها LIKESوهاتلى طولهم
          likes.add(value.docs.length);

          // دى هتجيب list هتجيب كل postId بالترتيب هتكون مظبوطه مع posts
          postsId.add(element.id);
          posts.add(PostModel.fromJson(element.data()));
        }).catchError((error) {});
      });
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          comments.add(value.docs.length);
        }).catchError((error) {});
      });
      emit(SocialGetPostsSuccessState());
    }).catchError((error) {
      emit(SocialGetPostsErrorState(error.toString()));
    });
  }

  void likePost(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('likes')
        .doc(Usermodel.uId)
        .set({
      'like': true,
    }).then((value) {
      emit(SocialLikePostSuccessState());
    }).catchError((error) {
      emit(SocialLikePostErrorState(error.toString()));
    });
  }

  List<TextEditingController> textController = [];
  var CommentController;

  void commentPost(String postId, String text) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .doc(Usermodel.uId)
        .set({
      'comment': text,
    }).then((value) {
      CommentController = TextEditingController();
      textController.add(CommentController);
      emit(SocialCommentPostSuccessState());
    }).catchError((error) {
      emit(SocialCommentPostErrorState(error.toString()));
    });
  }

  List<SocialUserModel> users = [];

  void getUsers() {
    if (users.length == 0)
      FirebaseFirestore.instance.collection('users').get().then((value) {

        value.docs.forEach((element) {

          if (element.data()['uId'] != Usermodel.uId)

            users.add(SocialUserModel.fromJson(element.data()));
        });
        emit(SocialGetAllUserSuccessState());
      }).catchError((error) {
        emit(SocialGetAllUserErrorState(error.toString()));
      });
  }

  void sendMessage({
    required String receiverId,
    required String dataTime,
    required String text,
    String? image,
  }) {
    MessageModel model = MessageModel(
      text: text,
      receiverId: receiverId,
      dataTime: dataTime,
      senderId: Usermodel.uId,
      image: image??'',
    );
    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(Usermodel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
    //set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(Usermodel.uId)
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

late  List<MessageModel> messsages ;

  void getMessages({required String receiverId}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(Usermodel.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages').orderBy('dataTime')
        .snapshots()
        .listen((event) {
      messsages = [];
           event.docs.forEach((element) {
             messsages.add(MessageModel.fromJson(element.data()));
           });
           emit(SocialGetMessageSuccessState());
    });

  }


  File? MessageImage;

  Future<void> getMessageImage() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      MessageImage = File(pickedFile.path);
      print(pickedFile.path);
      emit(SocialMessageImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(SocialMessageImagePickedErrorState());
    }
  }

  void removeMessageImage() {
    MessageImage = null;
    emit(SocialRemoveMessageImageState());
  }

  void UploadMessageImage({required String receiverId,
    required String dataTime,
    required String text,}) async {
    emit(SocialMessageImageLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(MessageImage!.path).pathSegments.last}')
        .putFile(MessageImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendMessage(receiverId: receiverId, dataTime: dataTime, text: text, image: value);

        print(value);
      }).catchError((error) {
        emit(SocialMessageImageErrorState(error.toString()));
      });
    }).catchError((error) {
      emit(SocialMessageImageErrorState(error.toString()));
    });
  }
}
