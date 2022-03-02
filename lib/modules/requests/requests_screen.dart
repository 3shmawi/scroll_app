import 'package:flutter/material.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            Expanded(
              child: InkWell(
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 45.0,
                      backgroundImage: NetworkImage(
                          'https://image.freepik.com/free-photo/pleasant-looking-serious-man-stands-profile-has-confident-expression-wears-casual-white-t-shirt_273609-16959.jpg'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mohamed Ashmawi',
                            style: Theme.of(context).textTheme.bodyText2,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'bio  ...',
                            style: Theme.of(context).textTheme.caption,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Decline',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.redAccent,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: OutlinedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Accepted',
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                          color: Colors.blueAccent,
                                        ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                onTap: () {},
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ],
        ),
      ),
      separatorBuilder: (context, index) => const Divider(
        height: 0.0,
        color: Colors.grey,
        endIndent: 20,
        indent: 20,
        thickness: 0.5,
      ),
      itemCount: 10,
    );
  }
}
