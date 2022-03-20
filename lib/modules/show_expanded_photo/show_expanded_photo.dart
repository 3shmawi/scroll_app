import 'package:flutter/material.dart';
import 'package:scroll/shared/styles/icon_broken.dart';

class ShowExpandedPhoto extends StatelessWidget {
  String? photo;

  ShowExpandedPhoto(this.photo, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: photo != null
              ? Stack(
                  children: [
                    Center(
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image(
                          image: NetworkImage(
                            photo!,
                          ),
                          //fit: BoxFit.fill,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        IconBroken.Arrow___Left_2,
                        color: Colors.white,
                      ),
                    ),
                  ],
                )
              : Container(),
        ),
      ),
    );
  }
}
