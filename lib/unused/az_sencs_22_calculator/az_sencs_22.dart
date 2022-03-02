import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scroll/unused/az_sencs_22_calculator/cubit/states.dart';

import 'cubit/cubit.dart';

class Calculator extends StatelessWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CalculatorCubit(),
      child: BlocConsumer<CalculatorCubit, CalculateStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = CalculatorCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: AnimatedTextKit(
                animatedTexts: [
                  WavyAnimatedText(
                    'Welcome Everyone!  -_-',
                    textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black87,
                          fontSize: 18.0,
                        ),
                  ),
                  WavyAnimatedText(
                    'My name is Mohamed Ashmawi...',
                    textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black87,
                          fontSize: 18.0,
                        ),
                  ),
                  WavyAnimatedText(
                    'I wish u have a good time.',
                    textStyle: Theme.of(context).textTheme.bodyText1?.copyWith(
                          color: Colors.black54,
                          fontSize: 15.0,
                        ),
                  ),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              cubit.input,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 5,
                            ),
                            const SizedBox(
                              height: 170,
                            ),
                            //const Spacer(),
                            Expanded(
                              child: ListView.builder(
                                reverse: true,
                                shrinkWrap: true,
                                //clipBehavior: Clip.antiAlias,
                                dragStartBehavior: DragStartBehavior.start,
                                addAutomaticKeepAlives: false,
                                itemBuilder: (context, index) =>
                                    viewText(index, cubit),
                                itemCount: cubit.list1.length,
                              ),
                            ),

                            Container(
                              height: 1.0,
                              width: double.infinity,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 5.0,
                              ),
                              child: Text(
                                cubit.error
                                    ? cubit.textError
                                    : '${cubit.result}',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 10.0,
                      bottom: 8.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.removeAllInput();
                                },
                                child: const Text(
                                  'AC',
                                  style: TextStyle(
                                    height: 1.65,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: TextButton(
                              onPressed: () {
                                cubit.changeInput('π');
                              },
                              child: const Text(
                                'π',
                                style: TextStyle(
                                  height: 1.5,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 5.0,
                        ),
                        defaultButton('%', cubit),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.changeInput('÷');
                                },
                                child: const Text(
                                  '÷',
                                  style: TextStyle(
                                    height: 1.45,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        defaultButton('7', cubit),
                        defaultButton('8', cubit),
                        defaultButton('9', cubit),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.changeInput('x');
                                },
                                child: const Icon(
                                  Icons.clear,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        defaultButton('4', cubit),
                        defaultButton('5', cubit),
                        defaultButton('6', cubit),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.changeInput('-');
                                },
                                child: const Icon(
                                  Icons.remove,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        defaultButton('1', cubit),
                        defaultButton('2', cubit),
                        defaultButton('3', cubit),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.changeInput('+');
                                },
                                child: const Icon(
                                  Icons.add,
                                  size: 20,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      children: [
                        defaultButton('0', cubit),
                        Expanded(
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey[200],
                            ),
                            child: TextButton(
                              onPressed: () {
                                cubit.changeInput('.');
                              },
                              child: const Text(
                                '.',
                                style: TextStyle(
                                  fontSize: 30,
                                  height: 0.8,
                                  fontWeight: FontWeight.bold,
                                ),
                                //textAlign: TextAlign.right,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.removeLastInput();
                                },
                                child: const Icon(
                                  Icons.backspace_outlined,
                                  color: Colors.blueAccent,
                                  size: 22,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.grey[200],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  cubit.equalPressed();
                                },
                                child: const Text(
                                  '=',
                                  style: TextStyle(
                                    height: 1.45,
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget defaultButton(String icon, CalculatorCubit cubit) => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(right: 5.0),
          child: Container(
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[200],
            ),
            child: TextButton(
              onPressed: () {
                cubit.changeInput(icon);
              },
              child: Text(
                icon,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );

  Widget viewText(item, CalculatorCubit cubit) => Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          InkWell(
            child: Text(
              cubit.list1[item].toString(),
              style: const TextStyle(fontSize: 20, color: Colors.grey),
            ),
            onTap: () {
              cubit.lastInput(cubit.list1[item].toString());
            },
          ),
          Text(
            cubit.list2[item].toString(),
            style: const TextStyle(
              fontSize: 15,
              color: Colors.black54,
            ),
          ),
        ],
      );
}
