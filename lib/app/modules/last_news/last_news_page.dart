import 'package:challenge_bt_app/app/global/custom/app_colors.dart';
import 'package:challenge_bt_app/app/global/widgets/nav_rail.dart';
import 'package:challenge_bt_app/app/modules/last_news/controllers/news_controller.dart';
import 'package:challenge_bt_app/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewsPage extends StatelessWidget {
  final _newsController = Get.put(NewsController());

  Widget news(int i) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: AppColors.blue,
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 0,
            left: 5,
            child: Obx(
              () => Text(
                'created_at: ' + _newsController.noticiasValue[i].message.createdAt,
                style: TextStyle(fontSize: 10),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                textDirection: TextDirection.rtl,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: 80,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: AppColors.secondaryOrange,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20.0),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/news.jpg'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Obx(
                            () => Text(
                              '@' + _newsController.noticias[i].user.name,
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(height: 10),
                          Obx(
                            () => SelectableText(_newsController.noticias[i].message.content),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () => Get.toNamed('/profile'),
            child: Obx(
              () => CircleAvatar(
                backgroundImage: NetworkImage(
                    Get.find<ProfileController>().userProfileValue.image.url,
                    scale: 1.0),
              ),
            ),
          ),
        ),
        title: Row(
          children: [
            Text(
              'Notícias',
              style: TextStyle(color: AppColors.textWhite),
            ),
            SizedBox(width: 20),
            Icon(
              Icons.now_widgets,
              color: AppColors.textWhite,
            ),
          ],
        ),
      ),
      body: Center(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            CustomNavigationRails(),
            VerticalDivider(
              thickness: 1.5,
              width: 1.5,
              color: AppColors.blue,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _newsController.getPosts(),
                child: Obx(
                  () => ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _newsController.noticiasValue.length,
                    itemBuilder: (context, i) => news(i),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
