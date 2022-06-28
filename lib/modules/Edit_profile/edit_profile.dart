import 'dart:io';

import 'package:firebase1/layout/cubic/cubic.dart';
import 'package:firebase1/layout/cubic/states.dart';
import 'package:firebase1/shared/componnents0/components.dart';
import 'package:firebase1/shared/network/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatelessWidget {
  var nameController = TextEditingController();
  var bioController = TextEditingController();
  var phoneController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubic, SocailStates>(
      builder: (context, state) {

       var userModel = SocailCubic.get(context).Usermodel;
         var profileImage = SocailCubic.get(context).profileImage;
       var coverImage = SocailCubic.get(context).coverImage;
        nameController.text=userModel.name;
        phoneController.text=userModel.phone;
        bioController.text=userModel.bio;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left),
            ),
            titleSpacing: 5.0,
            title: Text('Editprofile'),
            actions: [
              defaultButton(
                  width: 160,
                  shape: false,
                  background: Colors.white,
                  colortext: Colors.blue,
                  fontSize: 20,
                  function: () {
                    SocailCubic.get(context).updataUser(name: nameController.text, bio: bioController.text, phone: phoneController.text);
                  },
                  text: 'Update'),
              SizedBox(
                width: 15,
              )
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
if(state is SocialUserupdataLoadingState)
                  LinearProgressIndicator(),
                  if(state is SocialUserupdataLoadingState)
                  SizedBox(height: 10,),
                  Container(
                    height: 180,
                    child: Stack(
                        alignment: AlignmentDirectional.bottomCenter,
                        children: [
                          Align(
                            child: Stack(
                                alignment: AlignmentDirectional.topEnd,
                                children: [
                                  Container(
                                    height: 140,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4)),
                                        image: DecorationImage(
                                          image: coverImage == null
                                              ?
                                          NetworkImage('${userModel.cover}'):FileImage(coverImage) as ImageProvider,
                                          fit: BoxFit.cover,
                                        )),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        SocailCubic.get(context).getCoverImage();
                                      },
                                      icon: CircleAvatar(
                                          radius: 20,
                                          child: Icon(IconBroken.Camera)))
                                ]),
                            alignment: AlignmentDirectional.topCenter,
                          ),
                          Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              CircleAvatar(
                                radius: 53,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                child: CircleAvatar(
                                  radius: 50,
                                  backgroundImage: profileImage == null
                                      ? NetworkImage('${userModel.image}'):FileImage(profileImage) as ImageProvider ,

                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    SocailCubic.get(context).getProfileImage();
                                  },
                                  icon: CircleAvatar(
                                      radius: 20, child: Icon(IconBroken.Camera)))
                            ],
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if(SocailCubic.get(context).profileImage !=null||SocailCubic.get(context).coverImage !=null  )
                    Row(children: [
                      if(SocailCubic.get(context).profileImage !=null)
                        Expanded(child: Column(children: [defaultButton(function: (){
                          SocailCubic.get(context).uploadProfileImage(name: nameController.text, bio: bioController.text, phone: phoneController.text,);
                        }, text: 'upload profile '), if(state is SocialUserupdataLoadingState)LinearProgressIndicator(),])),
                      SizedBox(
                        width: 5,
                      ),
                      if(SocailCubic.get(context).coverImage !=null)

                        Expanded(child: Column(children: [ defaultButton(function: (){
                          SocailCubic.get(context).uploadCoverImage(name: nameController.text, bio: bioController.text, phone: phoneController.text,);
                        }, text: 'upload cover '),if(state is SocialUserupdataLoadingState) LinearProgressIndicator(),])),
                    ],),

                  SizedBox(
                    height: 20,
                  ),
                  defaultFormField(
                      controller: nameController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'name must not be empty';
                        }
                        return null;
                      },
                      label: 'Name',
                      prefix: IconBroken.User),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: bioController,
                      type: TextInputType.text,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'name must not be bio';
                        }
                        return null;
                      },
                      label: 'Bio',
                      prefix: IconBroken.Info_Circle),
                  SizedBox(
                    height: 10,
                  ),
                  defaultFormField(
                      controller: phoneController,
                      type: TextInputType.phone,
                      validate: (value) {
                        if (value.isEmpty) {
                          return 'phone number must not be bio';
                        }
                        return null;
                      },
                      label: 'Phone',
                      prefix: IconBroken.Call)
                ],
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
