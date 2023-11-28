import 'package:bookscan_1/src/helper/app_bar.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostDetailScreen extends StatelessWidget {
  final int index;

  PostDetailScreen({required this.index});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: PageAppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 게시물 이미지
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: 10),
                child: Image(
                  width: 380,
                  height: 380,
                  image: AssetImage(
                    'assets/images/post_detail_image/아몬드_독후감.png',
                  )
                ),
              ),
            ),
            // 게시물 정보 및 사용자 정보
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage('https://img.freepik.com/premium-vector/cute-bear-animal-icon_24911-4829.jpg'),
                ),
                title: Text('꿈꾸는 곰돌이'),
                subtitle: Text('Caption for post 2'),
              ),
            ),
            // 댓글 목록
            Container(
              height: 2,
              width: 500,
              color: Colors.black12,
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://pds.joongang.co.kr/news/component/htmlphoto_mmdata/202306/25/488f9638-800c-4bac-ad65-82877fbff79b.jpg'),
                    ),
                    title: Text('현서01'),
                    subtitle: Text('감동이에요ㅠㅠㅠ'),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage('https://img.freepik.com/free-photo/cute-ai-generated-cartoon-bunny_23-2150288873.jpg'),
                    ),
                    title: Text('밍주김'),
                    subtitle: Text('아몬드 꼭 읽어봐야겠네요!!'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
