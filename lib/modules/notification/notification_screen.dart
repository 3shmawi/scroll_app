import 'package:flutter/material.dart';

import '../../models/notificationModel.dart';
import '../../shared/components/constants.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // return  BlocConsumer<HomeCubit,HomeStates>(
    // listener: (BuildContext context, Object? state) {},
    // builder : (BuildContext context, Object? state) {
    //   var cubit = HomeCubit.get(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: ListView.separated(
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) =>
              notificationItem(notificationList[index], context),
          separatorBuilder: (context, index) => Container(
                height: 1.0,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
          itemCount: notificationList.length),
    );
    //  });
  }

  Widget notificationItem(NotificationModel notification, context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              backgroundImage:
                  NetworkImage(notification.senderImage.toString()),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${notification.senderName}',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(
                      width: 5.0,
                    ),
                    Text(
                      'Sent you message.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${daysBetween(DateTime.parse(notification.dateTime.toString()))} ago',
                  style: Theme.of(context).textTheme.caption,
                )
                //   Text(daysBetween(DateTime.parse('')),style: Theme.of(context).textTheme.caption)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
