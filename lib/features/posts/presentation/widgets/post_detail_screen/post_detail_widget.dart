
import 'package:clean_architecture_posts/features/posts/presentation/widgets/post_detail_screen/update_post_button_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../domain/entities/post_entity.dart';

import 'delete_post_button_widget.dart';

class PostDetailWidget extends StatelessWidget {
  final Post post;

  const PostDetailWidget({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Column(
        children: [
          Text(
            post.title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Divider(
            height: 50,
          ),
          Text(
            post.body,
            style: TextStyle(fontSize: 16),
          ),
          Divider(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              UpdatePostButtonWidget(post : post) ,
              DeletePostButtonWidget(postId: post.id! ) ,

            ],
          )
        ],
      ),
    );
  }

}
