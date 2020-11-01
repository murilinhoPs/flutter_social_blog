import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfilePage extends StatelessWidget {
  final _profileController = Get.find<ProfileController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.toNamed('/'),
            child: Obx(
              () => CircleAvatar(
                backgroundImage:
                    NetworkImage(_profileController.userProfileValue.image.url, scale: 1.0),
              ),
            ),
          ),
        ),
      ),
      body: Flex(direction: Axis.vertical, children: [
        Center(
          child: Obx(
            () => Column(
              children: //[
                  _profileController.userProfileValue.posts
                      .map(
                        (post) => Text('Postagem1: ' + post.post.content),
                      )
                      .toList(),
              // RichText(
              //   text: TextSpan(
              //     children: [
              //       TextSpan(
              //         text: 'Username:' +
              //             _profileController.userProfileValue.username +
              //             ' com id: ' +
              //             _profileController.userProfileValue.id.toString(),
              //       ),
              //       TextSpan(text: 'Email:' + _profileController.userProfileValue.email),
              //       TextSpan(
              //         text: 'Email:' + _profileController.userProfileValue.bio.content,
              //       ),
              //     ],
              //   ),
              // ),
              // ],
            ),
          ),
        ),
      ]),
    );
  }
}
