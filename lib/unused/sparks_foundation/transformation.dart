import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/shared/components/constants.dart';
import 'package:scroll/unused/sparks_foundation/cubit/cubit.dart';
import 'package:scroll/unused/sparks_foundation/cubit/states.dart';

class Transformation extends StatelessWidget {
  int index;

  var idController = TextEditingController();
  var withdrawController = TextEditingController();
  var depositController = TextEditingController();
  var transferController = TextEditingController();

  var formKey = GlobalKey<FormState>();
  int flag = 0;

  Transformation(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BankCubit, BankStates>(
      listener: (context, state) {
        if (state is UpdateDatabaseSuccessState) {
          idController.clear();
          withdrawController.clear();
          depositController.clear();
          transferController.clear();
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'User Info..',
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Container(
                      height: 220,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Salary :',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                ),
                                const Spacer(),
                                Text(
                                  '${users[index]['salary']} \$',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontSize: 30,
                                      ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Name :  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  '  ${users[index]['name']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'Email  :  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  '  ${users[index]['email']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              children: [
                                Text(
                                  'id  :  ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                Text(
                                  '  ${users[index]['id']}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: Colors.white,
                                      ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                flag = 1;
                                if (formKey.currentState!.validate()) {
                                  BankCubit.get(context).withdraw(users[index],
                                      double.parse(withdrawController.text));
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('withdraw'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (flag == 1 && value!.isEmpty) {
                                  return 'salary must not be empty';
                                } else if (flag == 1 &&
                                    double.parse(withdrawController.text) >
                                        users[index]['salary']) {
                                  return 'there is not enough money';
                                }
                                return null;
                              },
                              controller: withdrawController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'enter the amount...',
                                hintMaxLines: 1,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                flag = 2;
                                if (formKey.currentState!.validate()) {
                                  BankCubit.get(context).deposit(users[index],
                                      double.parse(depositController.text));
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('  deposit  '),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (flag == 2 && value!.isEmpty) {
                                  return 'salary must not be empty';
                                }
                                return null;
                              },
                              controller: depositController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'enter the amount...',
                                hintMaxLines: 1,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: OutlinedButton(
                              onPressed: () {
                                flag = 3;
                                if (formKey.currentState!.validate()) {
                                  BankCubit.get(context).transfer(
                                      index,
                                      double.parse(transferController.text),
                                      int.parse(idController.text));
                                }
                              },
                              child: const Padding(
                                padding: EdgeInsets.symmetric(vertical: 16.0),
                                child: Text('  transfer '),
                              ),
                            ),
                          ),
                          Expanded(
                            child: TextFormField(
                              validator: (value) {
                                if (flag == 3 && value!.isEmpty) {
                                  return 'salary must not be empty';
                                }
                                if (flag == 3 &&
                                    double.parse(transferController.text) >
                                        users[index]['salary']) {
                                  return 'there is not enough money';
                                }
                                return null;
                              },
                              controller: transferController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: 'enter the amount...',
                                hintMaxLines: 1,
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 5.0),
                            child: Text(
                              'to',
                              style: TextStyle(
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 1,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (flag == 3 && value!.isEmpty) {
                          return 'please enter user\'s id';
                        }
                        if (flag == 3 &&
                            (users[index]['id'] ==
                                    int.parse(idController.text) ||
                                int.parse(idController.text) < 0 ||
                                int.parse(idController.text) > 10)) {
                          return 'un correct id';
                        }

                        return null;
                      },
                      controller: idController,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        hintText:
                            'please enter user\'s id which u want to transfer...',
                        hintMaxLines: 1,
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
