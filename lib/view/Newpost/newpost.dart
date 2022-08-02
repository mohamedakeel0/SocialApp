import 'package:firebase1/bloc/cubic/cubic.dart';
import 'package:firebase1/bloc/cubic/states.dart';


import 'package:firebase1/shared/network/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewPost_Screen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var userModel = SocailCubic.get(context).Usermodel;
    TextEditingController textController = TextEditingController();
    var postImage = SocailCubic.get(context).postImage;
    return BlocConsumer<SocailCubic, SocailStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconBroken.Arrow___Left),
            ),
            title: const Text('Create post'),
            actions: [
              TextButton(
                  onPressed: () {
                    final now = DateTime.now();
                    if (SocailCubic.get(context).postImage == null) {
                      SocailCubic.get(context).CeatePost(
                          dataTime: now.toString(), text: textController.text);
                    } else {
                      SocailCubic.get(context).UploadPostImage(
                          dataTime: now.toString(), text: textController.text);
                    }
                  },
                  child: Text(
                    'Post',
                    style: TextStyle(fontSize: 20),
                  ))
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if (state is SocialCreatePostLoadingState)
                  LinearProgressIndicator(),
                if (state is SocialCreatePostLoadingState)
                  SizedBox(
                    height: 10,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Expanded(
                        child: Row(
                      children: [
                        Text(
                          '${userModel.name}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle2!
                              .copyWith(height: 1.3),
                        ),
                      ],
                    )),
                  ],
                ),
                Expanded(
                    child: TextFormField(
                  controller: textController,
                  decoration: InputDecoration(
                      hintText: 'what is on your mind ...',
                      border: InputBorder.none),
                )),
                SizedBox(
                  height: 20,
                ),
             SocailCubic.get(context).postImage != null?
                  Stack(alignment: AlignmentDirectional.topEnd, children: [
                    Container(
                      height: 140,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(4.0),
                          image: DecorationImage(
                            image: postImage != null
                                ? FileImage(postImage)
                                : FileImage(postImage!),
                            fit: BoxFit.cover,
                          )),
                    ),
                    IconButton(
                        onPressed: () {
                          SocailCubic.get(context).removePostImage();
                        },
                        icon:
                            CircleAvatar(radius: 20, child: Icon(Icons.close)))
                  ]):Container(),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton(
                        onPressed: () {
                          SocailCubic.get(context).getPostImage();


                        },
                        child: Row(
                          children: [
                            Icon(IconBroken.Image),
                            SizedBox(
                              width: 5,
                            ),
                            Text('add photo'),
                          ],
                        )),
                    Expanded(
                      child:
                          TextButton(onPressed: () {}, child: Text('# tags')),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
