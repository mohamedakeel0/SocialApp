import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/bloc/cubic/states.dart';


import 'package:firebase1/shared/componnents0/components.dart';
import 'package:firebase1/shared/network/style/icon_broken.dart';
import 'package:firebase1/view/Newpost/newpost.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import 'cubic/cubic.dart';

class Socail_layout extends StatelessWidget {
  const Socail_layout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubic, SocailStates>(
        listener: (context, state) {
          if(state is SocialNewPostState){
            navigateTo(context, NewPost_Screen());
          }
        },
        builder: (context, state) {
          var cubic = SocailCubic.get(context);
          return Scaffold(
            appBar: AppBar(
              title: Text(cubic.titles[cubic.currentIndex],),actions: [IconButton(onPressed: (){}, icon:Icon( IconBroken.Notification)),
              IconButton(onPressed: (){}, icon:Icon( IconBroken.Search))
            ],
            ),
            body: cubic.screens[cubic.currentIndex],
            bottomNavigationBar: BottomNavigationBar(currentIndex: cubic.currentIndex,
              onTap: (index) {
              cubic.changeBottomNav(index);
              },
              items: [
                BottomNavigationBarItem(icon: Icon(IconBroken.Home),label: 'Home'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Chat),label: 'Chat'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Paper_Upload),label: 'Post'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Location),label: 'Location'),
                BottomNavigationBarItem(icon: Icon(IconBroken.Setting),label: 'Setting'),
              ],
            ),
          );
        });
  }
}
