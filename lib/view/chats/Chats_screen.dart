import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/bloc/cubic/cubic.dart';
import 'package:firebase1/bloc/cubic/states.dart';

import 'package:firebase1/models/social_user_model.dart';

import 'package:firebase1/shared/componnents0/components.dart';
import 'package:firebase1/shared/network/style/colors.dart';
import 'package:firebase1/view/chat_details/chat_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chats_screen extends StatelessWidget {
  const Chats_screen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubic, SocailStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition:SocailCubic.get(context).users.length>0&&SocailCubic.get(context).Usermodel!=null ,builder:(context) =>  ListView.separated(
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) => buildChatItem(context,SocailCubic.get(context).users[index]),
            separatorBuilder: (context, index) => myDivider(),
            itemCount: SocailCubic.get(context).users.length), fallback: (context) => Center(child: CircularProgressIndicator(),),
        );
      },
    );
  }

  Widget buildChatItem(context,SocialUserModel model) => InkWell(
        onTap: () {
          navigateTo(context, ChatdDetails(userModel: model,));
        },
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundImage: NetworkImage(
                    '${model.image}'),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                '${model.name}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(height: 1.3),
              ),
            ],
          ),
        ),
      );
}
