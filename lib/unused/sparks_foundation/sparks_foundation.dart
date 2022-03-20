import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/unused/sparks_foundation/cubit/cubit.dart';
import 'package:scroll/unused/sparks_foundation/cubit/states.dart';
import 'package:scroll/unused/sparks_foundation/transformation.dart';


import '../../shared/components/constants.dart';

class SparksQuiz extends StatelessWidget {
  const SparksQuiz({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankCubit, BankStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            elevation: 5,
            title: const Text(
              'Bank Account',
            ),
            centerTitle: true,
          ),
          body: users.isNotEmpty
              ? ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) => Card(
              elevation: 7.0,
              margin: const EdgeInsets.only(left: 15.0, right: 8),
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.grey[200],
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Transformation(index),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(5),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blueAccent,
                        radius: 30,
                        child: Text(
                          '#${users[index]['id']}',
                          style: const TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                              ),
                              child: Text(
                                '${users[index]['name']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ),
                            Padding(
                              padding:
                              const EdgeInsets.only(left: 8.0, top: 2),
                              child: Text(
                                '${users[index]['email']}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.bottomEnd,
                        child: Text(
                          '${users[index]['salary']} \$',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: 10,
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }

}
