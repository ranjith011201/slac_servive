import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:slac_serve/helpers/screen_navigation.dart';
import 'package:slac_serve/providers/posts.dart';
import 'package:share/share.dart';
import 'package:slac_serve/screens/otherProfile.dart';

class ContributorWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final postsProvider = Provider.of<PostsProvider>(context);

    ByCategory() async {
      await postsProvider.loadPostsByCategory(categoryName: 'Contribution');
      print('fhsrthsrhdrth');
    }

    @override
    void initState() {
      ByCategory();
    }

    void sharePost({String text, String imageUrl, String description}) {
      final RenderBox box = context.findRenderObject();
      Share.share(text + '\n' + description + '\n' + imageUrl,
          subject: imageUrl,
          sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size);
    }

    return ListView.builder(
        itemCount: postsProvider.postsByContribution.length,
        itemBuilder: (ctx, i) {
          print(postsProvider.posts.length);
          return Container(
            width: double.infinity,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    changeScreen(context, OtherProfile());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.amberAccent,
                          child: Image.network(
                              'https://firebasestorage.googleapis.com/v0/b/slac-serve.appspot.com/o/profile1.png?alt=media&token=10bd0dc8-dcd5-49e8-9a7b-2a65db68faec'),
                        ),
                        SizedBox(width: 6),
                        Text(
                          postsProvider.postsByContribution[i].name,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 5 / 4,
                  child: Container(
                    color: Colors.amberAccent,
                    child: Image.network(postsProvider.posts[i].imageUrl),
                  ),
                ),
                SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: DefaultTextStyle.merge(
                          style: TextStyle(color: Colors.white),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(postsProvider.postsByContribution[i].title,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              ReadMoreText(
                                postsProvider
                                    .postsByContribution[i].description,
                                trimLines: 2,
                                trimMode: TrimMode.Line,
                                trimCollapsedText: ' read_more',
                                trimExpandedText: ' read_less',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        sharePost(
                            text: postsProvider.postsByContribution[i].title,
                            description: postsProvider.posts[i].description,
                            imageUrl: postsProvider.posts[i].imageUrl);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
              ],
            ),
          );
        });
  }
}
