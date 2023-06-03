import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:twitterclone/features/tweet/widgets/tweet_card.dart';
import 'package:twitterclone/models/tweet_model.dart';

class TwitterReply extends ConsumerWidget {

  static route(Tweet tweet) => MaterialPageRoute(
    builder: (context) =>  TwitterReply(
      tweet: tweet,
    ) 
  );
  
  final Tweet tweet;
  const TwitterReply({
    super.key,
    required this.tweet
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tweet' ),
      ),
      body: Column(
        children: [
          TweetCard(tweet: tweet )
        ],
      ),
    );
  }
}