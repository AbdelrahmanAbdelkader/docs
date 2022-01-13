import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/provider/account.dart';
import 'package:sample/screens/postscreen/posts/normal_post.dart';
import 'package:sample/screens/postscreen/posts/vote_post.dart';
import 'package:sample/screens/postscreen/postsaddscreen/posts_add_screen.dart';
import 'package:sample/screens/widgets/app_bar_button.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen(this.posts, {Key? key}) : super(key: key);
  final List<Map<String, dynamic>> posts;
  @override
  Widget build(BuildContext context) {
    print(posts);
    final size = MediaQuery.of(context).size;
    final account = Provider.of<Account>(context);
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: Text('نتائج الغلطة :('),
        actions: [
          AppBarButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (ctx) => ChangeNotifierProvider.value(
                      value: account, child: PostsAddScreen()),
                ),
              );
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned(
            bottom: 0,
            child: Container(
              width: size.width,
              child: Image.asset(
                'assets/background.png',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            width: size.width,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: Container(
                    width: size.width,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: posts.length,
                      itemBuilder: (ctx, i) => (posts[i]['type'] == 'important')
                          ? StreamBuilder<DatabaseEvent>(
                              stream: FirebaseDatabase.instance
                                  .ref()
                                  .child('posts')
                                  .child(posts[i]['key'])
                                  .onValue,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting)
                                  return Center(
                                      child: CircularProgressIndicator());
                                if (snapshot.data != null) {
                                  Map data =
                                      snapshot.data!.snapshot.value as Map;
                                  if (snapshot.data!.snapshot.value != null)
                                    return Container(
                                      width: size.width * .5,
                                      child: NormalPost(
                                        important: data['type'] == 'important',
                                        date: DateTime.parse(data['date']),
                                        text: data['text'],
                                        volName: data['volName'],
                                        images:
                                            ((data['images'] as List).isEmpty)
                                                ? null
                                                : data['images'],
                                      ),
                                    );
                                }
                                return Container();
                              })
                          : Container(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: posts.length,
                    itemBuilder: (ctx, i) => (posts[i]['type'] == 'normal' ||
                            posts[i]['type'] == 'important')
                        ? StreamBuilder<DatabaseEvent>(
                            stream: FirebaseDatabase.instance
                                .ref()
                                .child('posts')
                                .child(posts[i]['key'])
                                .onValue,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting)
                                return CircularProgressIndicator();
                              if (snapshot.data != null) {
                                Map data = snapshot.data!.snapshot.value as Map;
                                if (snapshot.data!.snapshot.value != null)
                                  return NormalPost(
                                    important: data['type'] == 'important',
                                    date: DateTime.parse(data['date']),
                                    text: data['text'],
                                    volName: data['volName'],
                                    images: ((data['images'] as List).isEmpty)
                                        ? null
                                        : data['images'],
                                  );
                              }
                              return Text('حدث خطأ في عرض ذلك البوست');
                            })
                        : (posts[i]['type'] == 'pole')
                            ? StreamBuilder<DatabaseEvent>(
                                stream: FirebaseDatabase.instance
                                    .ref()
                                    .child('posts')
                                    .child(posts[i]['key'])
                                    .onValue,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting)
                                    return CircularProgressIndicator();
                                  if (snapshot.data != null) {
                                    Map data =
                                        snapshot.data!.snapshot.value as Map;
                                    if (snapshot.data!.snapshot.value != null)
                                      return VotePost(
                                        votes: data['votes'],
                                        volName: data['volName'],
                                        date: DateTime.parse(data['date']),
                                        text: data['text'],
                                      );
                                  }
                                  return Text('حدث خطأ في عرض ذلك البوست');
                                })
                            : Container(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
