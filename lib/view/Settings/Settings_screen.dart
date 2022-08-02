import 'package:firebase1/bloc/cubic/cubic.dart';
import 'package:firebase1/bloc/cubic/states.dart';


import 'package:firebase1/shared/componnents0/components.dart';
import 'package:firebase1/shared/network/style/icon_broken.dart';
import 'package:firebase1/view/Edit_profile/edit_profile.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Settings_screen extends StatelessWidget {
  const Settings_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubic, SocailStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var userModel = SocailCubic.get(context).Usermodel;
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  height: 180,
                  child: Stack(
                      alignment: AlignmentDirectional.bottomCenter,
                      children: [
                        Align(
                          child: Container(
                            height: 140,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4)),
                                image: DecorationImage(
                                  image: NetworkImage('${userModel.cover}'),
                                  fit: BoxFit.cover,
                                )),
                          ),
                          alignment: AlignmentDirectional.topCenter,
                        ),
                        CircleAvatar(
                          radius: 53,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          child: CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage('${userModel.image}'),
                          ),
                        )
                      ]),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  '${userModel.name}',
                  style: Theme.of(context).textTheme.bodyText1,
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${userModel.bio}',
                  style: Theme.of(context).textTheme.caption,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '100',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'posts',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '450',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'photos',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '10',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Followers',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          child: Column(
                            children: [
                              Text(
                                '75',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                'Followings',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                          onPressed: () {}, child: Text('Add Photo')),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          navigateTo(context, EditProfileScreen());
                        },
                        child: Icon(
                          IconBroken.Edit,
                          size: 16,
                        ))
                  ],
                ),
                Row(
                  children: [
                    OutlinedButton(onPressed: () {
                      FirebaseMessaging.instance.subscribeToTopic('announcements');
                    }, child: Text('Subscribe')),
                    SizedBox(
                      width: 28,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          FirebaseMessaging.instance.unsubscribeFromTopic('announcements');
                        }, child: Text('unsubscribe')),
                  ],
                )
              ],
            ),
          );
        });
  }
}
