import 'package:flutter/material.dart';


class Test extends StatelessWidget {
  const Test({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(
          Icons.arrow_back,
        ),
        title: const Text('welcome'),
        actions: const [
          Icon(
            Icons.search,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                child:Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:  [
                    const Text('  input',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const Spacer(),
                   Padding(
                     padding: const EdgeInsets.all( 10.0),
                     child: Container(
                       color: Colors.black,
                       height: 1.0,
                       width: double.infinity,
                     ),
                   ),
                    const Text('  result',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    const SizedBox(height: 5.0,),
                  ],
                )
              ),
            ),
          ),
          Row(
            children: [
              defaultButton('AC'),
              defaultButton('DC'),
              defaultButton('%'),
              defaultButton('/'),
            ],
          ),
          Row(
            children: [
              defaultButton('7'),
              defaultButton('8'),
              defaultButton('9'),
              defaultButton('*'),
            ],
          ),
          Row(
            children: [
              defaultButton('4'),
              defaultButton('5'),
              defaultButton('6'),
              defaultButton('-'),
            ],
          ),
          Row(
            children: [
              defaultButton('1'),
              defaultButton('2'),
              defaultButton('3'),
              defaultButton('+'),
            ],
          ),
          Row(
            children: [
              defaultButton('0'),
              defaultButton('.'),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: TextButton(
                      onPressed: () {},
                      child: const Icon(
                        Icons.backspace_outlined,
                      ),
                    ),
                  ),
                ),
              ),
              defaultButton('='),
            ],
          ),
        ],
      ),
    );
  }

  Widget defaultButton(String string) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextButton(
              onPressed: () {},
              child: Text(
                string,
              ),
            ),
          ),
        ),
      );
}
