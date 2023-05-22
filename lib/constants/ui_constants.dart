import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:twitterclone/features/tweet/widgets/tweet_list.dart';
import './constants.dart';
// import './features/explore/view/explore_view.dart';
// import './features/notifications/views/notification_view.dart';
// import './features/tweet/widgets/tweet_list.dart';
import '../theme/pallete.dart';

class UIConstants {
  static AppBar appBar() {
    return AppBar(
      title: SvgPicture.asset(
        AssetsConstants.twitterLogo,
        color: Pallete.blueColor,
        height: 30,
      ),
      centerTitle: true,
    );
  }


 static const List<Widget> bottomTabBarPages = [
    TweetList(),
    Text('Search screen'),
    Text('Notification screen'),
  ];
//   static const List<Widget> bottomTabBarPages = [
//     TweetList(),
//     ExploreView(),
//     NotificationView(),
//   ];
}
