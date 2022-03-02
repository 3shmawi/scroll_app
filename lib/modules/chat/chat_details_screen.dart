import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/shared/styles/colors.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

import '../../layout/cubit/cubit.dart';
import '../../layout/cubit/states.dart';
import '../../models/message_model.dart';
import '../../models/user_model.dart';
import '../../shared/components/constants.dart';

class ChatDetails extends StatelessWidget {
  var sendMessageController = TextEditingController();
  var listController = ScrollController();

  UserModel receiverUser;

  ChatDetails(this.receiverUser, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MasterCubit, MasterStates>(
      listener: (BuildContext context, Object? state) {
        if (state is SendMessageSuccessState) {
          sendMessageController.clear();
          Timer(
              const Duration(seconds: 1),
              () => listController
                  .jumpTo(listController.position.maxScrollExtent));
        }
      },
      builder: (BuildContext context, Object? state) {
        var cubit = MasterCubit.get(context);
        if (cubit.messages.isNotEmpty) {
          Timer(
              const Duration(seconds: 1),
              () => listController
                  .jumpTo(listController.position.maxScrollExtent));
        }
        String userName = '';
        for (int i = 0; i < receiverUser.name.toString().length; i++) {
          if (receiverUser.name![i] == ' ') {
            break;
          }
          userName += receiverUser.name![i];
        }
        return Scaffold(
            appBar: AppBar(
              titleSpacing: 0.0,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  IconBroken.Arrow___Left_2,
                  color: Colors.black,
                ),
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 19,
                    backgroundImage:
                        NetworkImage(receiverUser.image.toString()),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    userName,
                    style: Theme.of(context).textTheme.bodyText1?.copyWith(
                          fontSize: 17,
                        ),
                  ),
                ],
              ),
            ),
            bottomSheet: BottomSheet(
              builder: (BuildContext context) => Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        IconBroken.Camera,
                        color: Colors.red,
                      ),
                    ),
                    Expanded(
                      child: Container(
                        height: 40.0,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16.0),
                          color: Colors.grey[300],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10.0),
                          child: TextFormField(
                            maxLines: null,
                            minLines: 1,
                            autofocus: true,
                            controller: sendMessageController,
                            keyboardType: TextInputType.text,
                            decoration: const InputDecoration(
                              hintText: 'Send a Message...',
                              border: InputBorder.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (sendMessageController.text.isNotEmpty) {
                          cubit.sendMessage(
                            receiverID: receiverUser.uId.toString(),
                            text: sendMessageController.text,
                            receiverUser: receiverUser,
                          );
                        }
                      },
                      icon: const Icon(
                        IconBroken.Send,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
              onClosing: () {},
            ),
            body: state is GetMessageLoadingState
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : cubit.messages.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.only(
                          left: 20,
                          right: 20,
                          top: 20,
                          bottom: 100,
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: ListView.separated(
                                  controller: listController,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    if (cubit.messages[index].senderId ==
                                        cubit.user!.uId) {
                                      return sendMessage(
                                          cubit.messages[index], context);
                                    } else {
                                      return receiveMessage(
                                          cubit.messages[index], context);
                                    }
                                  },
                                  separatorBuilder: (context, index) =>
                                      const SizedBox(
                                        height: 15,
                                      ),
                                  itemCount: cubit.messages.length),
                            ),
                          ],
                        ),
                      )
                    : const Center(
                        child: Text('Start your first chat'),
                      ));
      },
    );
  }

  // Widget bottomSheetDesign(MasterCubit cubit, Object? state) {
  //   return Padding(
  //     padding: const EdgeInsets.all(5.0),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: [
  //         IconButton(
  //           onPressed: () {},
  //           icon: const Icon(
  //             IconBroken.Camera,
  //             color: defaultColor,
  //           ),
  //         ),
  //         const SizedBox(
  //           width: 5,
  //         ),
  //         Expanded(
  //           child: Form(
  //             key: formKey,
  //             child: TextFormField(
  //               // enabled: state is SendMessageSuccessState ? false : true,
  //               maxLines: null,
  //               minLines: 1,
  //               autofocus: true,
  //               controller: sendMessageController,
  //               keyboardType: TextInputType.text,
  //               decoration: const InputDecoration(
  //                 hintText: 'Send Message...',
  //                 suffixIcon: Icon(IconBroken.Send, color: defaultColor),
  //                 border: InputBorder.none,
  //               ),
  //               onTap: () {
  //                 if (sendMessageController.text.isNotEmpty) {
  //                   cubit.sendMessage(
  //                       receiverID: receiverUser.uId.toString(),
  //                       text: sendMessageController.text,
  //                       receiverUser: receiverUser);
  //                 }
  //               },
  //             ),
  //           ),
  //         )
  //       ],
  //     ),
  //   );
  // }

  Widget sendMessage(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          decoration: BoxDecoration(
            color: defaultColor.withOpacity(
              .2,
            ),
            borderRadius: const BorderRadiusDirectional.only(
              bottomStart: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                model.text.toString(),
              ),
              Text(
                daysBetween(DateTime.parse(model.dateTime.toString())),
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
        ),
      );

  Widget receiveMessage(MessageModel model, context) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(
                10.0,
              ),
              topStart: Radius.circular(
                10.0,
              ),
              topEnd: Radius.circular(
                10.0,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 5.0,
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.text.toString(),
              ),
              Text(
                daysBetween(DateTime.parse(model.dateTime.toString())),
                style:
                    Theme.of(context).textTheme.caption!.copyWith(fontSize: 8),
              ),
            ],
          ),
        ),
      );

// Widget sendMessages(MessageModel message, context) {
//   return Align(
//     alignment: AlignmentDirectional.centerStart,
//     child: Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//           color: defaultColor.shade100,
//           borderRadius: const BorderRadiusDirectional.only(
//               topEnd: Radius.circular(10.0),
//               topStart: Radius.circular(10.0),
//               bottomEnd: Radius.circular(10.0))),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: Text(message.text.toString()),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             daysBetween(DateTime.parse(message.dateTime.toString())),
//             style: Theme.of(context).textTheme.caption,
//           ),
//         ],
//       ),
//     ),
//   );
// }
//
// Widget receiveMessages(MessageModel message, context) {
//   return Align(
//     alignment: AlignmentDirectional.bottomEnd,
//     child: Container(
//       padding: const EdgeInsets.all(8.0),
//       decoration: BoxDecoration(
//           color: Colors.grey.shade200,
//           borderRadius: const BorderRadiusDirectional.only(
//               topEnd: Radius.circular(10.0),
//               topStart: Radius.circular(10.0),
//               bottomStart: Radius.circular(10.0))),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(right: 20.0),
//             child: Text(message.text.toString()),
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             daysBetween(DateTime.parse(message.dateTime.toString())),
//             style:
//                 Theme.of(context).textTheme.caption!.copyWith(fontSize: 10),
//           ),
//         ],
//       ),
//     ),
//   );
// }
}
