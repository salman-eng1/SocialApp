import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_app/cubit/cubit.dart';
import 'package:social_app/layouts/social_app/cubit/states.dart';
import 'package:social_app/models/social_app/post_model.dart';
import 'package:social_app/shared/styles/IconBroken.dart';
import 'package:social_app/shared/styles/colors.dart';

class FeedsScrees extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var cubit=SocialCubit.get(context);
    return BlocConsumer<SocialCubit,SocialStates>(
      listener: (BuildContext context, state) {  },
      builder: (BuildContext context, Object? state) {
        return ConditionalBuilder(
          condition: cubit.posts.length >0,
          fallback: (BuildContext context)=> Center(child: CircularProgressIndicator()),
          builder: (BuildContext context)  =>SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                Card(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  elevation: 5.0,
                  margin: EdgeInsets.all(8.0),
                  child: Stack(alignment: AlignmentDirectional.bottomEnd, children: [
                    Image(
                      image: NetworkImage(
                          'https://newevolutiondesigns.com/images/freebies/nature-facebook-cover-4.jpg'
                      ),
                      fit: BoxFit.cover,
                      height: 250.0,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'communicate with friends',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    )
                  ]),
                ),
                ListView.separated(
                  itemBuilder:(context,index)=> buildPostItem(cubit.posts[index],context,index),
                  itemCount: cubit.posts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  separatorBuilder: (BuildContext context, int index)=>SizedBox(height: 8.0,),

                ),
                SizedBox(height: 8.0,),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget buildPostItem(PostModel postModel,context,index)=>Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage: NetworkImage(
                    '${postModel.image}'
                ),
              ),
              SizedBox(
                width: 15.0,
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${postModel.name}',
                            style: TextStyle(
                              height: 1.4,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            width: 5.0,
                          ),
                          Icon(
                            Icons.check_circle,
                            color: defaultColor,
                            size: 16.0,
                          ),
                        ],
                      ),
                      Text(
                        '${postModel.dateTime}',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  )),
              SizedBox(
                width: 15.0,
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.more_horiz,
                    size: 16.0,
                  ))
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical:15.0 ),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Text(
            '${postModel.text}',
            style: Theme.of(context).textTheme.subtitle1!,),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 10.0,top: 10.0,),
          //   child: Container(
          //     width: double.infinity,
          //     child: Wrap(
          //       children: [
          //         Padding(
          //           padding: const EdgeInsets.only(
          //               right: 6.0
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text('#software_Development',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor,
          //                   )),
          //             ),
          //           ),
          //         ),
          //         Padding(
          //           padding: const EdgeInsets.only(
          //               right: 6.0
          //           ),
          //           child: Container(
          //             height: 25.0,
          //             child: MaterialButton(
          //               onPressed: (){},
          //               minWidth: 1.0,
          //               padding: EdgeInsets.zero,
          //               child: Text('#software_Development',
          //                   style: Theme.of(context).textTheme.caption!.copyWith(
          //                     color: defaultColor,
          //                   )),
          //             ),
          //           ),
          //         ),
          //
          //
          //       ],
          //     ),
          //   ),
          // ),
          if (postModel.postImage!='')
          Padding(
            padding: const EdgeInsetsDirectional.only(top: 15.0),
            child: Container(
              height: 140.0,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4.0),
                image: DecorationImage(
                  image: NetworkImage(
                      '${postModel.postImage}'
                  ),
                  fit: BoxFit.cover,


                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      SocialCubit.get(context).likePosts(SocialCubit.get(context).postsId[index]);


                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        children: [
                          Icon(IconBroken.Heart,size: 16.0,color: Colors.red,),
                          SizedBox(width: 5.0,),
                          Text('${SocialCubit.get(context).likes[index]+1}',
                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: (){},
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(IconBroken.Chat,size: 16.0,color: Colors.amber,),
                          SizedBox(width: 5.0,),
                          Text('90 comments',
                            style: Theme.of(context).textTheme.caption,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0),
            child: Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
          ),
          Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            '${SocialCubit.get(context).userModel.image}'
                        ),
                      ),
                      SizedBox(
                        width: 15.0,
                      ),
                      Text(
                        'Write a comment ...',
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(height: 1.4),
                      ),
                    ],
                  ),
                  onTap: (){},
                ),
              ),
              InkWell(
                onTap: (){},
                child: Row(
                  children: [
                    Icon(IconBroken.Heart,size: 16.0,color: Colors.red,),
                    SizedBox(width: 5.0,),
                    Text('Like',
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),

            ],
          ),



        ],
      ),
    ),
  );

}
