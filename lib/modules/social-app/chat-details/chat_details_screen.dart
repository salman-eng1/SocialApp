import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:social_app/layouts/social_app/cubit/cubit.dart';
import 'package:social_app/layouts/social_app/cubit/states.dart';
import 'package:social_app/models/social_app/message_model.dart';
import 'package:social_app/models/social_app/social_user_model.dart';
import 'package:social_app/shared/styles/IconBroken.dart';
import 'package:social_app/shared/styles/colors.dart';

class ChatDetailsScreen extends StatelessWidget {
  late SocialUserModel userModel;
  ChatDetailsScreen({required this.userModel});
  var messageController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        SocialCubit.get(context).getMessages(
            receiverId: userModel.uId
        );

        return BlocConsumer<SocialCubit,SocialStates>(
          listener: (BuildContext context, Object? state) {},
          builder: (BuildContext context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 20.0,
                      backgroundImage: NetworkImage('${userModel.image}'),
                    ),
                    SizedBox(width: 15.0,),
                    Text('${userModel.name}'),
                  ],
                ),
              ),
              body: ConditionalBuilder(
                condition: SocialCubit.get(context).messages.length>0 ,
                fallback: (BuildContext context) => Center(
                      child: CircularProgressIndicator(),
                  ),

                builder: (BuildContext context) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                     Expanded(
                       child: ListView.separated(
                         physics: BouncingScrollPhysics(),
                           itemBuilder: (context,index){
                             var message= SocialCubit.get(context).messages[index];
                             if(SocialCubit.get(context).userModel.uId== message.senderId)
                               return buildSenderMessage(message);
                             return buildReceiverMessage(message);
                },
                           separatorBuilder: (context,state)=>SizedBox(height: 15.0,),
                           itemCount: SocialCubit.get(context).messages.length,
                    ),
                     ),
                        Container(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              )
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: messageController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: '  type your message here ...',
                                  ),
                                ),
                              ),
                              Container(
                                height: 50.0,
                                color: defaultColor,
                                child: MaterialButton(
                                  onPressed: (){
                                    SocialCubit.get(context).sendMessage(
                                      receiverId: userModel.uId,
                                      dateTime: DateTime.now().toString(),
                                      text: messageController.text,
                                    );
                                    messageController.text='';
                                  },
                                  minWidth: 1.0,
                                  child: Icon(IconBroken.Send,
                                    size: 16.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                  ),


              ),
            );
          },
        );

      },
    );
  }
}
Widget buildSenderMessage (MessageModel model) => Align(
  alignment: AlignmentDirectional.centerStart,
  child: Container(
      decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      child: Text('${model.text}'),
  ),
);
Widget buildReceiverMessage(MessageModel model) => Align(
  alignment: AlignmentDirectional.centerEnd,
  child: Container(
      decoration: BoxDecoration(
          color: defaultColor.withOpacity(.2),
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(10.0),
            topStart: Radius.circular(10.0),
            topEnd: Radius.circular(10.0),
          )
      ),
      padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 10.0),
      child: Text('${model.text}'),
  ),
);

