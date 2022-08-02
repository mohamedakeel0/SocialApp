import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/bloc/cubic/cubic.dart';
import 'package:firebase1/bloc/cubic/states.dart';

import 'package:firebase1/models/MessageModel.dart';
import 'package:firebase1/models/social_user_model.dart';
import 'package:firebase1/shared/network/style/colors.dart';
import 'package:firebase1/shared/network/style/icon_broken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatdDetails extends StatelessWidget {
  late SocialUserModel userModel;

  ChatdDetails({required this.userModel});

  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      SocailCubic.get(context).getMessages(receiverId: userModel.uId);
      return BlocConsumer<SocailCubic, SocailStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage('${userModel.image}'),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text('${userModel.name}',
                      style: Theme.of(context).textTheme.subtitle2!),
                ],
              ),
            ),
            body: ConditionalBuilder(
              condition: SocailCubic.get(context).messsages != null,
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.separated(
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            var message =
                                SocailCubic.get(context).messsages[index];
                            print(message);
                            if (SocailCubic.get(context).Usermodel.uId ==
                                message.senderId)
                              return buildMyMessage(message, context);
                            else
                              return buildMessage(message, context);
                          },
                          separatorBuilder: (context, index) => SizedBox(
                                height: 15,
                              ),
                          itemCount: SocailCubic.get(context).messsages.length),
                    ),
                    if (state is SocialMessageImagePickedSuccessState)
                      Stack(alignment: AlignmentDirectional.topEnd, children: [
                        Container(
                          height: 120,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4.0),
                              image: DecorationImage(
                                image: FileImage(
                                        SocailCubic.get(context).MessageImage!)
                                    as ImageProvider,
                                fit: BoxFit.cover,
                              )),
                        ),
                        IconButton(
                            onPressed: () {
                              SocailCubic.get(context).removePostImage();
                            },
                            icon: CircleAvatar(
                                radius: 20, child: Icon(Icons.close)))
                      ]),
                    Container(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey, width: 1.0),
                          borderRadius: BorderRadius.circular(15)),
                      child: Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: textController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  textController.text = '';
                                }
                              },
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'type your message here ....'),
                            ),
                          )),
                          Row(children: [
                            TextButton(
                                onPressed: () {
                                  SocailCubic.get(context).getMessageImage();
                                },
                                child: Icon(
                                  IconBroken.Image,
                                  size: 25,
                                )),
                            Container(
                                height: 50,
                                color: defaultcolor,
                                child: MaterialButton(
                                  onPressed: () {
                                    if (SocailCubic.get(context).MessageImage ==
                                        null) {
                                      SocailCubic.get(context).sendMessage(
                                          receiverId: userModel.uId,
                                          dataTime: DateTime.now().toString(),
                                          text: textController.text);
                                      SocailCubic.get(context)
                                          .removePostImage();
                                      textController.text = '';
                                    } else {
                                      SocailCubic.get(context)
                                          .UploadMessageImage(
                                              receiverId: userModel.uId,
                                              dataTime:
                                                  DateTime.now().toString(),
                                              text: textController.text);
                                      textController.text = '';
                                    }
                                  },
                                  minWidth: 1.0,
                                  child: Icon(
                                    IconBroken.Send,
                                    size: 16,
                                    color: Colors.white,
                                  ),
                                )),
                          ])
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              fallback: (context) => Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        },
      );
    });
  }

  Widget buildMessage(MessageModel model, context) => model.image != null && model.text.isNotEmpty
      ? Align(
    alignment: AlignmentDirectional.centerStart,
    child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10.0),
              topStart: Radius.circular(10),
              topEnd: Radius.circular(10),
            )),
        child: Column(
          children: [
            Container(
              width: 120,
              height: model.image == null ? 0 : 120,
              padding:
              EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('${model.image}'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  )),
            ),
            Container(
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadiusDirectional.only(
                    bottomEnd: Radius.circular(10.0),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  )),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  model.text,
                  style: TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ],
        )),
  )
      : model.image != null
      ? Align(
    alignment:  AlignmentDirectional.centerStart,
    child: Container(
      width: 120,
      height: 120,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('${model.image}'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )),
    ),
  )
      : model.text.isNotEmpty
      ? Align(
    alignment:  AlignmentDirectional.centerStart,
    child: Container(
      decoration: BoxDecoration(
          color:Colors.grey,
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10),
            topEnd: Radius.circular(10),
          )),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Text(
          model.text,
          style: TextStyle(color: Colors.white),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  )
      : Container();

  Widget buildMyMessage(MessageModel model, context) =>
      model.image != null && model.text.isNotEmpty
          ? Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadiusDirectional.only(
                    bottomStart: Radius.circular(10.0),
                    topStart: Radius.circular(10),
                    topEnd: Radius.circular(10),
                  )),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: model.image == null ? 0 : 120,
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                        decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${model.image}'),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(10.0),
                              topStart: Radius.circular(10),
                              topEnd: Radius.circular(10),
                            )),
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(10.0),
                              topStart: Radius.circular(10),
                              topEnd: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            model.text,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          : model.image != null
              ? Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: Container(
                    width: 120,
                    height: 120,
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${model.image}'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadiusDirectional.only(
                          bottomStart: Radius.circular(10.0),
                          topStart: Radius.circular(10),
                          topEnd: Radius.circular(10),
                        )),
                  ),
                )
              : model.text.isNotEmpty
                  ? Align(
                      alignment: AlignmentDirectional.centerEnd,
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.blueGrey,
                            borderRadius: BorderRadiusDirectional.only(
                              bottomStart: Radius.circular(10.0),
                              topStart: Radius.circular(10),
                              topEnd: Radius.circular(10),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Text(
                            model.text,
                            style: TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    )
                  : Container();

  Widget buildMyMessageImage(MessageModel model) =>
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage('${model.image}'),
                fit: BoxFit.cover,
              )),
        ),
      ]);

  Widget buildMessageImage(MessageModel model) =>
      Row(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          height: 150,
          width: 150,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              image: DecorationImage(
                image: NetworkImage('${model.image}'),
                fit: BoxFit.cover,
              )),
        ),
      ]);
}
