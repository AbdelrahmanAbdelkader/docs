import 'package:flutter/material.dart';
import 'package:sample/screens/postscreen/posts/normal_post.dart';
import 'package:sample/screens/postscreen/posts/vote_post.dart';
import 'package:sample/screens/postscreen/postsaddscreen/posts_add_screen.dart';
import 'package:sample/screens/widgets/app_bar_button.dart';

class PostsScreen extends StatelessWidget {
  PostsScreen({Key? key}) : super(key: key);
  List<Map<String, dynamic>> posts = [
    {
      'volName': 'محمود الهادي',
      'date': DateTime.now(),
      'text': 'موافقين ؟',
      'type': 'pole',
      'votes': [
        {
          'voteName': 'موافق',
          'quantity': 3,
          'selected': false,
        },
        {
          'voteName': 'مش موافق',
          'quantity': 2,
          'selected': false,
        },
        {
          'voteName': 'يعم لا',
          'quantity': 5,
          'selected': false,
        },
        {
          'voteName': 'محصلش',
          'quantity': 1,
          'selected': false,
        },
      ]
    },
    {
      'date': DateTime.now(),
      'text': 'عاش يا شباب',
      'volName': 'محمود الهادي',
      'images': [
        'assets/1.png',
        'assets/2.png',
      ],
      'type': 'important'
    },
    {
      'date': DateTime.now(),
      'text': 'عاش يا شباب',
      'volName': 'محمود الهادي',
      'images': [],
      'type': 'important',
    },
    {
      'date': DateTime.now(),
      'text': 'عاش يا شباب',
      'volName': 'محمود الهادي',
      'images': [
        'assets/1.png',
        'assets/4.png',
        'assets/3.png',
      ],
      'type': 'important',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
                  builder: (ctx) => PostsAddScreen(),
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
                          ? Container(
                              width: size.width * .5,
                              child: NormalPost(
                                important:
                                    posts[i]['type'] =='important',
                                date: posts[i]['date'],
                                text: posts[i]['text'],
                                volName: posts[i]['volName'],
                                images: ((posts[i]['images'] as List).isEmpty)
                                    ? null
                                    : posts[i]['images'],
                              ),
                            )
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
                        ? NormalPost(
                            important:
                                posts[i]['type'] == 'important',
                            date: posts[i]['date'],
                            text: posts[i]['text'],
                            volName: posts[i]['volName'],
                            images: ((posts[i]['images'] as List).isEmpty)
                                ? null
                                : posts[i]['images'],
                          )
                        : (posts[i]['type'] == 'pole')
                            ? VotePost(
                                votes: posts[i]['votes'],
                                volName: 'محمود الهادي',
                                date: posts[i]['date'],
                                text: posts[i]['text'],
                              )
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
