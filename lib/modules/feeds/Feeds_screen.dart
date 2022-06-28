import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase1/layout/cubic/cubic.dart';
import 'package:firebase1/layout/cubic/states.dart';
import 'package:firebase1/models/post_model.dart';
import 'package:firebase1/shared/network/style/colors.dart';
import 'package:firebase1/shared/network/style/icon_broken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Feeds_screen extends StatelessWidget {
  TextEditingController commentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocailCubic, SocailStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: SocailCubic.get(context).posts.length > 0 &&
              SocailCubic.get(context).Usermodel != null,
          builder: (context) => SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    elevation: 5,
                    margin: EdgeInsets.all(8),
                    child: Stack(
                      alignment: AlignmentDirectional.bottomEnd,
                      children: [
                        Image(
                          image: NetworkImage(
                              'https://img.freepik.com/free-photo/portrait-beautiful-young-woman-gesticulating_273609-41056.jpg?w=1380'),
                          fit: BoxFit.cover,
                          height: 250,
                          width: double.infinity,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'communicate with friends',
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white),
                          ),
                        ),
                      ],
                    )),
                ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                    itemBuilder: (context, index) => buildpostItem(
                        SocailCubic.get(context).posts[index], context, index),
                    itemCount: SocailCubic.get(context).posts.length),
                SizedBox(
                  height: 8,
                )
              ],
            ),
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildpostItem(PostModel model, context, index) => Card(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      margin: EdgeInsets.symmetric(horizontal: 8),
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage('${model.image}'),
                ),
                SizedBox(
                  width: 15,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${model.name}',
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1!
                              .copyWith(height: 1.3),
                        ),
                        Icon(
                          Icons.check_circle,
                          color: defaultcolor,
                          size: 16,
                        ),
                      ],
                    ),
                    Text('${model.dataTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.3))
                  ],
                )),
                SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                )
              ],
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Text(
              '${model.text}',
              style: Theme.of(context).textTheme.subtitle1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                child: Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 10),
                      child: Container(
                        height: 20,
                        child: MaterialButton(
                          onPressed: () {},
                          child: Text(
                            '#software',
                            style: TextStyle(color: Colors.blue),
                          ),
                          minWidth: 1.0,
                          padding: EdgeInsets.zero,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (model.postImage != '')
              Padding(
                padding: const EdgeInsetsDirectional.only(top: 15),
                child: Container(
                  height: 140,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage('${model.postImage}'),
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            Row(children: [
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocailCubic.get(context).likes[index]}',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          IconBroken.Chat,
                          color: Colors.amber,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          '${SocailCubic.get(context).comments[index]} comment',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  onTap: () {},
                ),
              ),
            ]),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 5),
              child: Container(
                width: double.infinity,
                height: 1,
                color: Colors.grey[300],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocailCubic.get(context).Usermodel.image}'),
                        ),SizedBox(width: 15,),
                        Expanded(
                            child: TextFormField(controller: SocailCubic.get(context).CommentController,
                              decoration: InputDecoration(
                                  hintText: 'write a comment ...',
                                  border: InputBorder.none),
                            )),

                        IconButton(
                          onPressed: () {
                            SocailCubic.get(context).commentPost(SocailCubic.get(context).postsId[index],SocailCubic.get(context).CommentController.text);
                          },
                          icon: Icon(
                            IconBroken.Send,
                            color: Colors.blue,
                            size: 22,
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(width: 20,),
                        Icon(
                          IconBroken.Heart,
                          color: Colors.red,
                          size: 20,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        )
                      ],
                    ),
                  ),
                  onTap: () {
                    SocailCubic.get(context)
                        .likePost(SocailCubic.get(context).postsId[index]);
                  },
                ),
              ],
            ),
          ],
        ),
      ));
}
