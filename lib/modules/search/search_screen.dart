import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class SizeTransition1 extends PageRouteBuilder {
  final Widget page;

  SizeTransition1(this.page)
      : super(
          pageBuilder: (context, animation, anotherAnimation) => page,
          transitionDuration: const Duration(milliseconds: 1000),
          reverseTransitionDuration: const Duration(milliseconds: 200),
          transitionsBuilder: (context, animation, anotherAnimation, child) {
            animation = CurvedAnimation(
                curve: Curves.fastLinearToSlowEaseIn,
                parent: animation,
                reverseCurve: Curves.fastOutSlowIn);
            return Align(
              alignment: Alignment.bottomCenter,
              child: SizeTransition(
                sizeFactor: animation,
                child: page,
                axisAlignment: 0,
              ),
            );
          },
        );
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   leading: IconButton(
        //     onPressed: () {
        //       Navigator.pop(context);
        //     },
        //     icon: const Icon(
        //       IconBroken.Arrow___Left_2,
        //     ),
        //   ),
        //   title: Container(
        //     height: 35.0,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(20.0),
        //       color: Colors.grey[300],
        //     ),
        //     child: Padding(
        //       padding: const EdgeInsets.only(left: 12.0),
        //       child: TextFormField(
        //         controller: searchController,
        //         decoration: const InputDecoration(
        //           hintText: 'Search',
        //           border: InputBorder.none,
        //         ),
        //       ),
        //     ),
        //   ),
        //   actions:  [
        //     IconButton(
        //       onPressed: (){},
        //       icon: const Icon(
        //         IconBroken.Search,
        //       ),
        //     ),
        //   ],
        // ),
        body: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    IconBroken.Arrow___Left_2,
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
                        controller: searchController,
                        decoration: const InputDecoration(
                          hintText: 'Search',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    setState(() {
                      getProfileImage();
                    });
                  },
                  icon: const Icon(
                    IconBroken.Send,
                    color: Colors.red,
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 1.0,
              color: Colors.grey[300],
            ),
            const SizedBox(
              height: 200,
            ),
            Center(
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: profileImage == null
                    ? const NetworkImage('https://fedoramagazine.org/wp-content/uploads/2017/05/f23.png-768x480.jpg') as ImageProvider
                    : FileImage(profileImage!),
              ),
            ),
          ],
        ),
      ),
    );
  }

  final ImagePicker _picker = ImagePicker();

  //profile image

  File? profileImage;

  Future<void> getProfileImage() async {
    if (profileImage != null) {
      profileImage = null;
    }
    await _picker.pickImage(source: ImageSource.camera).then((value) {
     setState(()=> profileImage = File(value!.path));
    }).catchError((error) {
      print(error.toString());
    });
  }
}
