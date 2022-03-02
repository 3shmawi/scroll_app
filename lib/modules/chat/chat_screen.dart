import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/layout/cubit/cubit.dart';
import 'package:scroll/models/user_model.dart';

import '../../layout/cubit/states.dart';
import '../../shared/styles/colors.dart';
import 'chat_details_screen.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, Object? state) {
          var cubit = MasterCubit.get(context);

          return cubit.chatUsers.isNotEmpty
              ? ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) =>
                      chatItem(cubit.chatUsers[index], context),
                  separatorBuilder: (context, index) => Container(
                        height: 1.0,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                  itemCount: cubit.chatUsers.length)
              : const Center(
                  child: CircularProgressIndicator(),
                );
        });
  }

  Widget chatItem(UserModel chatUser, context) {
    return InkWell(
      onTap: () {
        MasterCubit.get(context)
            .getMessages(receiverID: chatUser.uId.toString());
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => ChatDetails(chatUser),
          ),
          (route) {
            return true;
          },
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(chatUser.image.toString()),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  chatUser.name.toString(),
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                // Text(daysBetween(DateTime.parse('')),style: Theme.of(context).textTheme.caption)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
